import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> loginWithCredentials(String nationalId, String password);
  Future<Map<String, dynamic>> loginWithStaffCode(String staffCode, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  // 1. تسجيل دخول المواطن
  @override
  Future<Map<String, dynamic>> loginWithCredentials(String nationalId, String password) async {
    try {
      final response = await supabaseClient
          .from('citizens')
          .select()
          .eq('national_id', nationalId)
          .eq('password', password)
          .maybeSingle();

      if (response == null) {
        throw Exception('الرقم القومي أو كلمة المرور غير صحيحة');
      }
      return response;
    } catch (e) {
      print('🔥 Supabase Citizen Error: $e');
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('حدث خطأ أثناء الاتصال بقاعدة البيانات');
    }
  }

  // 2. تسجيل دخول الكوادر الحكومية
  @override
  Future<Map<String, dynamic>> loginWithStaffCode(String staffCode, String password) async {
    try {
      // تنظيف المدخلات من أي مسافات زائدة قد تعيق المطابقة مع قاعدة البيانات
      final cleanCode = staffCode.trim();
      final cleanPassword = password.trim();

      print('🔍 Attempting login for staff: [$cleanCode]');

      final response = await supabaseClient
          .from('staff_accounts')
          .select('*, citizens!staff_accounts_citizen_id_fkey(*)')
          .eq('staff_code', cleanCode)
          .eq('staff_password', cleanPassword)
          .maybeSingle();

      if (response == null) {
        print('❌ Staff login returned null. Check if code and password match DB exactly.');
        throw Exception('الكود الوظيفي أو كلمة المرور غير صحيحة');
      }

      // التأكد من حالة الحساب الإدارية
      if (response['is_active'] == false || response['account_status'] != 'active') {
        throw Exception('هذا الحساب موقوف أو قيد المراجعة من الإدارة');
      }

      return response;
    } catch (e) {
      print('🔥 Supabase Staff Error: $e');
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('حدث خطأ أثناء الاتصال بقاعدة البيانات');
    }
  }
}