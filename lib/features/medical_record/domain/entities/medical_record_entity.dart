// lib/features/medical_record/domain/entities/medical_record_entity.dart

class MedicalRecordEntity {
  final String recordId;        // رقم السجل الطبي
  final String nationalId;      // الرقم القومي للمواطن المرتبط بالسجل
  final List<String> geneticConditions; // الأمراض الوراثية أو الاستعداد الجيني
  final List<String> chronicDiseases;   // الأمراض المزمنة (سكر، ضغط، إلخ)
  final List<String> allergies;         // الحساسية المفرطة (أدوية، أطعمة)
  final String lastCheckupDate; // تاريخ آخر فحص أو تحديث للسجل

  MedicalRecordEntity({
    required this.recordId,
    required this.nationalId,
    required this.geneticConditions,
    required this.chronicDiseases,
    required this.allergies,
    required this.lastCheckupDate,
  });

// (اختياري) ممكن نضيف هنا دوال مساعدة لو محتاجين نفلتر أو نتشيك على بيانات معينة جوا الكيان
}