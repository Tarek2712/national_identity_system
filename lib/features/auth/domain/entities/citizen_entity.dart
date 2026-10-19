import 'package:equatable/equatable.dart';

class CitizenEntity extends Equatable {
  final String id;
  final String nationalId;
  final String smartAltId;
  final String fullName;
  final String bloodType;
  final String status;
  final String role; // المتغير الجديد للصلاحية

  const CitizenEntity({
    required this.id,
    required this.nationalId,
    required this.smartAltId,
    required this.fullName,
    required this.bloodType,
    required this.status,
    required this.role, 
  });

  @override
  List<Object?> get props => [
    id,
    nationalId,
    smartAltId,
    fullName,
    bloodType,
    status,
    role,
  ];
}
