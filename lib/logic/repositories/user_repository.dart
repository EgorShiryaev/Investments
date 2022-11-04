import '../datasources/user_remote_datasource.dart';
import '../models/login_data.dart';
import '../models/user.dart';

class UserRepository {
  final UserRemoteDatasource _remoteDatasource; 

  const UserRepository({
    required UserRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  Future<User> login(LoginData data) {
    return _remoteDatasource.login(data);
  }

  Future<User> signUp(LoginData data) {
    return _remoteDatasource.signUp(data);
  }
}
