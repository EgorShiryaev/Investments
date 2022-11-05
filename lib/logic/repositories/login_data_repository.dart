import '../datasources/secure_local_datasource.dart';
import '../models/login_data.dart';

class LoginDataRepository {
  final SecureLocalDatasource _localDatasource;

  const LoginDataRepository({
    required SecureLocalDatasource localDatasource,
  }) : _localDatasource = localDatasource;

  Future<LoginData?> get previousLoginData async {
    final values = await Future.wait([
      _localDatasource.email,
      _localDatasource.password,
    ]);

    final email = values[0];
    final password = values[1];

    if (email == null || password == null) {
      return null;
    }

    return LoginData(email: email, password: password);
  }

  Future<void> saveLoginData(LoginData loginData) async {
    await Future.wait([
      _localDatasource.saveEmail(loginData.email),
      _localDatasource.savePassword(loginData.password),
    ]);
  }

  Future<void> deleteSavedLoginData() async {
    await Future.wait([
      _localDatasource.deleteSavedEmail(),
      _localDatasource.deleteSavedpassword(),
    ]);
  }
}
