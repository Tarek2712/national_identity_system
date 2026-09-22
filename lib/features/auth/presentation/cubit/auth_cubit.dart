import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> loginWithCredentials({
    required String nationalId,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      if (nationalId.isEmpty || password.isEmpty) {
        emit(const AuthError('يرجى إدخال جميع البيانات'));
        return;
      }

      final citizen = await authRepository.loginWithCredentials(nationalId, password);
      emit(AuthAuthenticated(citizen));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loginWithFaceId() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthError('لم يتم إعداد البصمة البيومترية لهذا الحساب بعد'));
  }
}