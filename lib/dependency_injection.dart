// ignore_for_file: cascade_invocations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'logic/datasources/secure_local_datasource.dart';
import 'logic/datasources/user_remote_datasource.dart';
import 'logic/repositories/login_data_repository.dart';
import 'logic/repositories/user_repository.dart';
import 'logic/usecases/login_data_usecases.dart';
import 'logic/usecases/user_usecases.dart';
import 'ui/blocs/auth_cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependency() async {
  final httpClient = http.Client();
  await _setupAuthModuleDependency(httpClient);
}

Future<void> _setupAuthModuleDependency(http.Client httpClient) async {
  getIt.registerFactory(
    () => AuthCubit(loginDataUsecases: getIt(), userUsecases: getIt()),
  );

  getIt.registerLazySingleton<LoginDataUsecases>(
    () => LoginDataUsecases(repository: getIt()),
  );

  getIt.registerLazySingleton<LoginDataRepository>(
    () => LoginDataRepository(localDatasource: getIt()),
  );

  getIt.registerLazySingleton<SecureLocalDatasource>(
    () => const SecureLocalDatasource(
      secureStorage: FlutterSecureStorage(),
    ),
  );

  getIt.registerLazySingleton<UserUsecases>(
    () => UserUsecases(repository: getIt()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(remoteDatasource: getIt()),
  );

  getIt.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(clien: httpClient),
  );
}
