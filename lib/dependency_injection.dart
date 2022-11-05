// ignore_for_file: cascade_invocations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'logic/datasources/secure_local_datasource.dart';
import 'logic/datasources/user_remote_datasource.dart';
import 'logic/repositories/auth_repository.dart';
import 'logic/repositories/previous_login_data_repository.dart';
import 'logic/usecases/auth_usecases.dart';
import 'logic/usecases/previous_login_data_usecases.dart';
import 'ui/blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import 'ui/blocs/login_cubit/login_cubit.dart';
import 'ui/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'ui/blocs/user_auth_cubit/user_auth_cubit.dart';

final getIt = GetIt.instance;

void setupDependency() {
  final httpClient = http.Client();
  _setupAuthModuleDependency(httpClient);
  _setupUserAuthModuleCubit();
}

void _setupUserAuthModuleCubit() {}

void _setupAuthModuleDependency(http.Client httpClient) {
  getIt.registerFactory<UserAuthCubit>(
    () => UserAuthCubit(
      previousLoginDataUsecases: getIt(),
      authUsecases: getIt(),
    ),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(authUsecases: getIt()),
  );
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(authUsecases: getIt()),
  );
  // ignore: unnecessary_lambdas
  getIt.registerFactory<AuthNavigationCubit>(() => AuthNavigationCubit());

  getIt.registerLazySingleton<PreviousLoginDataUsecases>(
    () => PreviousLoginDataUsecases(previousLoginDataRepository: getIt()),
  );
  getIt.registerLazySingleton<AuthUsecases>(
    () => AuthUsecases(authRepository: getIt()),
  );

  getIt.registerLazySingleton<PreviousLoginDataRepository>(
    () => PreviousLoginDataRepository(secureLocalDatasource: getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(authRemoteDatasource: getIt()),
  );

  getIt.registerLazySingleton<SecureLocalDatasource>(
    () => const SecureLocalDatasource(
      secureStorage: FlutterSecureStorage(),
    ),
  );
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(clien: httpClient),
  );
}
