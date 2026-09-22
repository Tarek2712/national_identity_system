import '../../domain/entities/citizen_entity.dart';

class CitizenModel extends CitizenEntity {
  const CitizenModel({
    required super.id,
    required super.fullName,
    required super.nationalId,
    required super.smartAltId,
    required super.bloodType,
    required super.status,
  });

  factory CitizenModel.fromJson(Map<String, dynamic> json) {
    return CitizenModel(
      id: json['id'].toString(),
      fullName: json['full_name'] ?? '',
      nationalId: json['national_id'] ?? '',
      smartAltId: json['smart_alt_id'] ?? '',
      bloodType: json['blood_type'] ?? '',
      status: json['status'] ?? '',
    );
  }
}