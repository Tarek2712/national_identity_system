import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final String role;
  final String department;
  AuthSuccess({required this.role, required this.department});
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _supabase = Supabase.instance.client;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      // 1. تسجيل الدخول عبر نظام Supabase Auth المركزي والمشفر
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      
      if (response.user == null) {
        emit(AuthFailure('فشل تسجيل الدخول. تأكد من البيانات.'));
        return;
      }

      // 2. جلب بيانات الموظف لمعرفة قطاعه ورتبته للتوجيه الذكي
      final staffData = await _supabase
          .from('staff_accounts')
          .select('role, department')
          .eq('auth_id', response.user!.id)
          .maybeSingle();

      if (staffData == null) {
        emit(AuthFailure('هذا الحساب غير مسجل كموظف في النظام.'));
        return;
      }

      final role = staffData['role'] as String? ?? 'employee';
      final department = staffData['department'] as String? ?? 'civil';

      emit(AuthSuccess(role: role, department: department));

    } on AuthException catch (e) {
      emit(AuthFailure('بيانات الدخول غير صحيحة.'));
    } catch (e) {
      emit(AuthFailure('حدث خطأ غير متوقع أثناء الاتصال بالخادم.'));
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
    emit(AuthInitial());
  }
}
