import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/citizen_entity.dart';

abstract class AuthRepository {
  Future<CitizenEntity> loginWithCredentials(String nationalId, String password);
  Future<CitizenEntity> loginWithStaffCode(String staffCode, String password); // الدالة الجديدة للموظفين

  Future<Either<Failure, CitizenEntity>> authenticateWithBiometrics();
  Future<Either<Failure, CitizenEntity>> getCitizenProfile(String identifier);
}