import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/medical_record_model.dart';

abstract class MedicalRecordRemoteDataSource {
  // تم تعديل المعامل هنا ليكون citizenId (الـ UUID) بدلاً من nationalId
  Future<MedicalRecordModel> getMedicalRecord(String citizenId);
}

class MedicalRecordRemoteDataSourceImpl implements MedicalRecordRemoteDataSource {
  final SupabaseClient supabaseClient;

  MedicalRecordRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<MedicalRecordModel> getMedicalRecord(String citizenId) async {
    try {
      // بنكلم جدول medical_records وبنبحث بالـ UUID بتاع المواطن
      final response = await supabaseClient
          .from('medical_records')
          .select()
          .eq('citizen_id', citizenId)
          .maybeSingle(); // استخدمنا maybeSingle عشان لو مفيش سجل ما يعملش Crash

      if (response == null) {
        throw Exception('لا يوجد سجل طبي وراثي مرتبط بهذا المواطن.');
      }

      return MedicalRecordModel.fromJson(response);
    } catch (e) {
      throw Exception('حدث خطأ أثناء جلب السجل الطبي الوراثي: $e');
    }
  }
}