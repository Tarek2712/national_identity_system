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

  // الدالة دي اتعدلت عشان تطابق أسماء الأعمدة اللي عندك في سوبابيز
  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      recordId: json['id'] ?? '', // متسمي عندك id
      nationalId: json['citizen_id'] ?? '', // متسمي عندك citizen_id

      // لأن الداتا عندك متسجلة كـ text، لو فيها كذا مرض هنفصلهم بفاصلة ونحولهم لـ List
      geneticConditions: (json['genetic_risks'] as String?)?.split(',') ?? [],
      chronicDiseases: (json['chronic_diseases'] as String?)?.split(',') ?? [],
      allergies: (json['allergies'] as String?)?.split(',') ?? [],

      lastCheckupDate: json['updated_at'] ?? '', // متسمي عندك updated_at
    );
  }
}