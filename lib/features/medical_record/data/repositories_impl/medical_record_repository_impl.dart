import '../../domain/repositories/medical_record_repository.dart';
import '../../domain/entities/medical_record_entity.dart';
import '../datasources/medical_record_remote_data_source.dart';

class MedicalRecordRepositoryImpl implements MedicalRecordRepository {
  final MedicalRecordRemoteDataSource remoteDataSource;

  MedicalRecordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MedicalRecordEntity> getMedicalRecord(String citizenId) async {
    // تمرير الـ citizenId للـ Data Source
    return await remoteDataSource.getMedicalRecord(citizenId);
  }
}