// ignore_for_file: cascade_invocations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'logic/datasources/recent_search_items_local_datasources.dart';
import 'logic/datasources/secure_local_datasource.dart';
import 'logic/datasources/user_remote_datasource.dart';
import 'logic/repositories/auth_repository.dart';
import 'logic/repositories/previous_login_data_repository.dart';
import 'logic/repositories/recent_search_items_repository.dart';
import 'logic/usecases/auth_usecases.dart';
import 'logic/usecases/previous_login_data_usecases.dart';
import 'logic/usecases/recent_search_items_usecases.dart';
import 'ui/blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import 'ui/blocs/login_cubit/login_cubit.dart';
import 'ui/blocs/recent_search_items_cubit/recent_search_items_cubit.dart';
import 'ui/blocs/search_page_content_cubit/search_page_content_cubit.dart';
import 'ui/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'ui/blocs/user_auth_cubit/user_auth_cubit.dart';

final getIt = GetIt.instance;

void setupDependency() {
  final httpClient = http.Client();
  _setupAuthModuleDependency(httpClient);
  _setupSearchModuleDependency(httpClient);
}

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
  getIt.registerFactory<AuthNavigationCubit>(AuthNavigationCubit.new);

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

void _setupSearchModuleDependency(http.Client httpClient) {
  getIt.registerFactory<SearchPageContentCubit>(SearchPageContentCubit.new);
  getIt.registerFactory<RecentSearchItemsCubit>(
    () => RecentSearchItemsCubit(
      usecases: getIt(),
    ),
  );

  getIt.registerLazySingleton<RecentSearchItemsUsecases>(
    () => RecentSearchItemsUsecases(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<RecentSearchItemsRepository>(
    () => RecentSearchItemsRepository(
      localDatasource: getIt(),
    ),
  );

  getIt.registerLazySingleton<RecentSearchItemsLocalDatasource>(
    RecentSearchItemsLocalDatasource.new,
  );
}
