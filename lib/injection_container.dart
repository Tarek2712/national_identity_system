import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:local_auth/local_auth.dart';

// المسارات الصحيحة للـ Clean Architecture بتاعتك
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // 1. Cubit
  sl.registerFactory(() => AuthCubit(authRepository: sl()));

  // 2. Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl(), localAuth: sl()),
  );

  // 3. Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(supabaseClient: sl()),
  );

  // 4. External Tools
  sl.registerLazySingleton(() => Supabase.instance.client);
  sl.registerLazySingleton(() => LocalAuthentication());
}