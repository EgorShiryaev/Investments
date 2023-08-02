import '../datasources/secure_local_datasource.dart';
import '../models/login_data.dart';

class PreviousLoginDataRepository {
  final SecureLocalDatasource _secureLocalDatasource;

  const PreviousLoginDataRepository({
    required SecureLocalDatasource secureLocalDatasource,
  }) : _secureLocalDatasource = secureLocalDatasource;

  Future<LoginData?> get previousLoginData async {
    final values = await Future.wait([
      _secureLocalDatasource.email,
      _secureLocalDatasource.password,
    ]);

    final email = values[0];
    final password = values[1];

    if (email == null || password == null) {
      return null;
    }

    return LoginData(email: email, password: password);
  }

  Future<void> save(LoginData loginData) async {
    await Future.wait([
      _secureLocalDatasource.saveEmail(loginData.email),
      _secureLocalDatasource.savePassword(loginData.password),
    ]);
  }

  Future<void> delete() async {
    await Future.wait([
      _secureLocalDatasource.deleteSavedEmail(),
      _secureLocalDatasource.deleteSavedPassword(),
    ]);
  }
}
