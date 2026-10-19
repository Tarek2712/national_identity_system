class MedicalRecordEntity {
  final String recordId;
  final String nationalId;
  final List<String> geneticConditions;
  final List<String> chronicDiseases;
  final List<String> allergies;
  final String lastCheckupDate;

  MedicalRecordEntity({
    required this.recordId,
    required this.nationalId,
    required this.geneticConditions,
    required this.chronicDiseases,
    required this.allergies,
    required this.lastCheckupDate,
  });
}