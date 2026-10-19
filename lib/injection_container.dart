import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:local_auth/local_auth.dart';

// --- Ù…Ø³Ø§Ø±Ø§Øª Ø§Ù„Ù€ Auth ---
import 'package:national_identity_system/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:national_identity_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:national_identity_system/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:national_identity_system/features/auth/data/datasources/auth_remote_data_source.dart';

// --- Ù…Ø³Ø§Ø±Ø§Øª Ø§Ù„Ù€ Medical Record ---
import 'package:national_identity_system/features/medical_record/presentation/cubit/medical_record_cubit.dart';
import 'package:national_identity_system/features/medical_record/domain/repositories/medical_record_repository.dart';
import 'package:national_identity_system/features/medical_record/data/repositories_impl/medical_record_repository_impl.dart';
import 'package:national_identity_system/features/medical_record/data/datasources/medical_record_remote_data_source.dart';

// --- Ù…Ø³Ø§Ø±Ø§Øª Ø§Ù„Ù€ Family Tree ---
import 'package:national_identity_system/features/family_tree/presentation/cubit/family_cubit.dart';
import 'package:national_identity_system/features/family_tree/domain/repositories/family_repository.dart';
import 'package:national_identity_system/features/family_tree/data/repositories/family_repository_impl.dart';

// --- Ù…Ø³Ø§Ø±Ø§Øª Ø§Ù„Ø·ÙˆØ§Ø±Ø¦ (Emergency) ---
import 'package:national_identity_system/features/emergency/presentation/cubit/emergency_cubit.dart';
import 'package:national_identity_system/features/emergency/domain/repositories/emergency_repository.dart';
import 'package:national_identity_system/features/emergency/data/repositories_impl/emergency_repository_impl.dart';

// --- Ù…Ø³Ø§Ø±Ø§Øª Ø³Ø¬Ù„ Ø§Ù„ØµÙ„Ø§Ø­ÙŠØ§Øª (Audit Logs) ---
import 'package:national_identity_system/features/audit_logs/presentation/cubit/audit_logs_cubit.dart';
import 'package:national_identity_system/features/audit_logs/domain/repositories/audit_logs_repository.dart';
import 'package:national_identity_system/features/audit_logs/data/repositories_impl/audit_logs_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ==========================================
  // 1. Cubits
  // ==========================================
  sl.registerFactory(() => AuthCubit());
  sl.registerFactory(() => MedicalRecordCubit(repository: sl()));
  sl.registerFactory(() => FamilyCubit(repository: sl()));
  sl.registerFactory(() => EmergencyCubit(repository: sl()));
  sl.registerFactory(() => AuditLogsCubit(repository: sl())); // ØªÙ…Øª Ø¥Ø¶Ø§ÙØ© Ø³Ø¬Ù„ Ø§Ù„ØµÙ„Ø§Ø­ÙŠØ§Øª

  // ==========================================
  // 2. Repositories
  // ==========================================
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localAuth: sl(),
    ),
  );
  sl.registerLazySingleton<MedicalRecordRepository>(
        () => MedicalRecordRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FamilyRepository>(
        () => FamilyRepositoryImpl(supabase: sl()),
  );
  sl.registerLazySingleton<EmergencyRepository>(
        () => EmergencyRepositoryImpl(supabase: sl()),
  );
  sl.registerLazySingleton<AuditLogsRepository>(
        () => AuditLogsRepositoryImpl(supabase: sl()), // ØªÙ…Øª Ø¥Ø¶Ø§ÙØ© Ø³Ø¬Ù„ Ø§Ù„ØµÙ„Ø§Ø­ÙŠØ§Øª
  );

  // ==========================================
  // 3. Data Sources
  // ==========================================
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(supabaseClient: sl()),
  );
  sl.registerLazySingleton<MedicalRecordRemoteDataSource>(
        () => MedicalRecordRemoteDataSourceImpl(supabaseClient: sl()),
  );

  // ==========================================
  // 4. External Services
  // ==========================================
  sl.registerLazySingleton(() => Supabase.instance.client);
  sl.registerLazySingleton(() => LocalAuthentication());
}


