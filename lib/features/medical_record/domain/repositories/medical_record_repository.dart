import '../entities/medical_record_entity.dart';

abstract class MedicalRecordRepository {
  // عقد بيلزمنا نعمل دالة بتجيب السجل الطبي باستخدام الرقم القومي
  Future<MedicalRecordEntity> getMedicalRecord(String nationalId);
}