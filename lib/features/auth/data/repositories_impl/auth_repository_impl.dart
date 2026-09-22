import 'package:local_auth/local_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/citizen_entity.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalAuthentication localAuth;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localAuth,
  });

  @override
  Future<CitizenEntity> loginWithCredentials(String nationalId, String password) async {
    final data = await remoteDataSource.loginWithCredentials(nationalId, password);

    // تحويل البيانات اللي جاية من Supabase للـ Entity بتاعك
    // تحويل البيانات اللي جاية من Supabase للـ Entity بتاعك
    return CitizenEntity(
      id: data['id'] ?? '',
      fullName: data['full_name'] ?? '',
      nationalId: data['national_id'] ?? '',
      smartAltId: data['smart_alt_id'] ?? '', // ضفنا الرقم البديل
      bloodType: data['blood_type'] ?? '',   // ضفنا فصيلة الدم
      status: data['status'] ?? '',          // ضفنا حالة المواطن
    );
  }
}