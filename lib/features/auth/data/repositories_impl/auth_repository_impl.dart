import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/citizen_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/citizen_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalAuthentication localAuth;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localAuth,
  });

  @override
  Future<Either<Failure, CitizenEntity>> authenticateWithBiometrics() async {
    try {
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'يرجى تأكيد الهوية باستخدام البصمة البيومترية للولوج إلى المنظومة',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        return const Right(CitizenEntity(
          id: '1',
          nationalId: '30201011234567', // رقم افتراضي للبصمة حالياً
          smartAltId: 'EGY-QR-987654',
          fullName: 'طارق سيد محمد',
          bloodType: 'O+',
          status: 'نشط',
          role: 'citizen', // إضافة الرتبة الافتراضية للبصمة
        ));
      } else {
        return const Left(BiometricFailure('فشل التحقق البيومتري'));
      }
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CitizenEntity>> getCitizenProfile(String identifier) async {
    return const Left(ServerFailure('سيتم برمجتها لاحقاً'));
  }

  // تسجيل دخول المواطن العادي
  @override
  Future<CitizenEntity> loginWithCredentials(String nationalId, String password) async {
    final response = await remoteDataSource.loginWithCredentials(nationalId, password);
    return CitizenModel.fromJson(response);
  }

  // تسجيل دخول الكوادر (الدالة الجديدة)
  @override
  Future<CitizenEntity> loginWithStaffCode(String staffCode, String password) async {
    final response = await remoteDataSource.loginWithStaffCode(staffCode, password);

    // بنسحب بيانات المواطن (الاسم والصورة الخ) اللي مربوطة بالموظف ده
    final citizenData = response['citizens'] as Map<String, dynamic>;

    // التعديل الأهم: بنغير صلاحية الـ role بتاعته من "مواطن" للـ role الوظيفي بتاعه (زي super_admin أو police)
    citizenData['role'] = response['role'];

    return CitizenModel.fromJson(citizenData);
  }
}