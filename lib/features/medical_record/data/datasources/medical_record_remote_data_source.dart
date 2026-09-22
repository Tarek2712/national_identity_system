import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/medical_record_model.dart';

abstract class MedicalRecordRemoteDataSource {
  Future<MedicalRecordModel> getMedicalRecord(String nationalId);
}

class MedicalRecordRemoteDataSourceImpl implements MedicalRecordRemoteDataSource {
  final SupabaseClient supabaseClient;

  MedicalRecordRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<MedicalRecordModel> getMedicalRecord(String nationalId) async {
    try {
      // هنا بنكلم جدول medical_records في سوبابيز ونجيب بيانات المواطن
      final response = await supabaseClient
          .from('medical_records')
          .select()
          .eq('national_id', nationalId)
          .single(); // single لأن كل مواطن ليه سجل واحد بس

      // بناخد الـ JSON اللي راجع ونحوله للـ Model النضيف بتاعنا
      return MedicalRecordModel.fromJson(response);
    } catch (e) {
      throw Exception('حدث خطأ أثناء جلب السجل الطبي الوراثي: $e');
    }
  }
}