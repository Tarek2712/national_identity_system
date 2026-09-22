import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> loginWithCredentials(String nationalId, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<Map<String, dynamic>> loginWithCredentials(String nationalId, String password) async {
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
  }
}