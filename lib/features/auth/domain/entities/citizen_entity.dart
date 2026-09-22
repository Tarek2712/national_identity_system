import 'package:equatable/equatable.dart';

class CitizenEntity extends Equatable {
  final String id;
  final String nationalId;
  final String smartAltId;
  final String fullName;
  final String bloodType;
  final String status;

  const CitizenEntity({
    required this.id,
    required this.nationalId,
    required this.smartAltId,
    required this.fullName,
    required this.bloodType,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    nationalId,
    smartAltId,
    fullName,
    bloodType,
    status,
  ];
}