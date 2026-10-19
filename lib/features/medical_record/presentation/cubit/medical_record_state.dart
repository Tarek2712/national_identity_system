import '../../domain/entities/medical_record_entity.dart';

abstract class MedicalRecordState {}

class MedicalRecordInitial extends MedicalRecordState {}

class MedicalRecordLoading extends MedicalRecordState {}

class MedicalRecordLoaded extends MedicalRecordState {
  final MedicalRecordEntity record;

  MedicalRecordLoaded({required this.record});
}

class MedicalRecordError extends MedicalRecordState {
  final String message;

  MedicalRecordError({required this.message});
}