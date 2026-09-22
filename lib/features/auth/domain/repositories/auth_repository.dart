import '../entities/citizen_entity.dart';

abstract class AuthRepository {
  Future<CitizenEntity> loginWithCredentials(String nationalId, String password);
}