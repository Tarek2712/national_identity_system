import '../../domain/repositories/medical_record_repository.dart';
import '../../domain/entities/medical_record_entity.dart';
import '../datasources/medical_record_remote_data_source.dart';

class MedicalRecordRepositoryImpl implements MedicalRecordRepository {
  final MedicalRecordRemoteDataSource remoteDataSource;

  // بنحقن الـ Data Source هنا عشان الـ Repository يعرف يكلمه
  MedicalRecordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MedicalRecordEntity> getMedicalRecord(String nationalId) async {
    // المدير (Repository) بيبعت الطلب للموظف (Data Source) ويرجع النتيجة
    return await remoteDataSource.getMedicalRecord(nationalId);
  }
}