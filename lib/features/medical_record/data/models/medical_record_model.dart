import '../../domain/entities/medical_record_entity.dart';

class MedicalRecordModel extends MedicalRecordEntity {
  MedicalRecordModel({
    required super.recordId,
    required super.nationalId,
    required super.geneticConditions,
    required super.chronicDiseases,
    required super.allergies,
    required super.lastCheckupDate,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      recordId: json['id']?.toString() ?? '',
      nationalId: json['citizen_id']?.toString() ?? '',
      geneticConditions: [json['genetic_risks']?.toString() ?? 'لا يوجد سجل وراثي'],
      chronicDiseases: [json['chronic_diseases']?.toString() ?? 'لا يوجد'],
      allergies: [json['allergies']?.toString() ?? 'لا يوجد'],
      lastCheckupDate: json['updated_at']?.toString() ?? 'غير محدد',
    );
  }
}