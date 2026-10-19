import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/medical_record_repository.dart';
import 'medical_record_state.dart';

class MedicalRecordCubit extends Cubit<MedicalRecordState> {
  final MedicalRecordRepository repository;

  MedicalRecordCubit({required this.repository}) : super(MedicalRecordInitial());

  Future<void> fetchMedicalRecord(String citizenId) async {
    emit(MedicalRecordLoading());
    try {
      final record = await repository.getMedicalRecord(citizenId);
      // التعديل هنا: بعتنا الـ record باستخدام الـ Named Parameter
      emit(MedicalRecordLoaded(record: record));
    } catch (e) {
      // التعديل هنا: بعتنا رسالة الخطأ باستخدام الـ Named Parameter
      emit(MedicalRecordError(message: e.toString().replaceAll('Exception: ', '')));
    }
  }
}