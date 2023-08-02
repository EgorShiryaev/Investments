// ignore_for_file: cascade_invocations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'logic/datasources/index.dart';
import 'logic/repositories/index.dart';
import 'logic/usecases/index.dart';
import 'ui/blocs/favorites/quotes_cubit.dart/quotes_cubit.dart';
import 'ui/blocs/index.dart';

final getIt = GetIt.instance;

void setupDependency() {
  final httpClient = http.Client();
  _setupAuthModuleDependency(httpClient);
  _setupSearchModuleDependency(httpClient);
  _setupFavoritesModuleDependency(httpClient);
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
  getIt.registerFactory<RecentSearchListCubit>(
    () => RecentSearchListCubit(
      usecases: getIt(),
    ),
  );
  getIt.registerFactory<SearchInstrumentsCubit>(
    () => SearchInstrumentsCubit(usecases: getIt()),
  );

  getIt.registerLazySingleton<RecentSearchListUsecases>(
    () => RecentSearchListUsecases(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchInstrumentsUsecases>(
    () => SearchInstrumentsUsecases(repository: getIt()),
  );

  getIt.registerLazySingleton<RecentSearchListRepository>(
    () => RecentSearchListRepository(
      localDatasource: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchInstrumentsRepository>(
    () => SearchInstrumentsRepository(
      remoteDatasource: getIt(),
    ),
  );

  getIt.registerLazySingleton<RecentSearchListLocalDatasource>(
    RecentSearchListLocalDatasource.new,
  );
  getIt.registerLazySingleton<SearchInstrumentsRemoteDatasource>(
    () => SearchInstrumentsRemoteDatasource(clien: httpClient),
  );
}

void _setupFavoritesModuleDependency(http.Client httpClient) {
  getIt.registerFactory<FavoriteInstrumentsCubit>(
    () => FavoriteInstrumentsCubit(usecases: getIt()),
  );
  getIt.registerFactory<QuotesCubit>(
    () => QuotesCubit(usecases: getIt()),
  );

  getIt.registerLazySingleton<FavoriteInstrumentsUsecases>(
    () => FavoriteInstrumentsUsecases(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<QoutesUsecases>(
    () => QoutesUsecases(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<FavoriteInstrumentsRepository>(
    () => FavoriteInstrumentsRepository(
      remoteDatasource: getIt(),
    ),
  );
  getIt.registerLazySingleton<QoutesRepository>(
    () => QoutesRepository(
      remoteDatasource: getIt(),
    ),
  );

  getIt.registerLazySingleton<FavoriteInstrumentsRemoteDatasource>(
    () => FavoriteInstrumentsRemoteDatasource(clien: httpClient),
  );
  getIt.registerLazySingleton<QuotesRemoteDatasource>(
    QuotesRemoteDatasource.new,
  );
}
