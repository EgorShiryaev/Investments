import '../datasources/user_remote_datasource.dart';
import '../models/login_data.dart';
import '../models/user.dart';

class AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  const AuthRepository({
    required AuthRemoteDatasource authRemoteDatasource,
  }) : _authRemoteDatasource = authRemoteDatasource;

  Future<User> login(LoginData data) {
    return _authRemoteDatasource.login(data);
  }

  Future<User> signUp(LoginData data) {
    return _authRemoteDatasource.signUp(data);
  }
}
