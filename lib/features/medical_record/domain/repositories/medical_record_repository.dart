import '../entities/medical_record_entity.dart';

abstract class MedicalRecordRepository {
  // غيرنا المعامل هنا لـ citizenId
  Future<MedicalRecordEntity> getMedicalRecord(String citizenId);
}