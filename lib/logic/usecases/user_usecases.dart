import '../models/login_data.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserUsecases {
  final UserRepository _repository;

  UserUsecases({
    required UserRepository repository,
  }) : _repository = repository;

  Future<User> login(LoginData data) {
    return _repository.login(data);
  }

  Future<User> signUp(LoginData data) {
    return _repository.signUp(data);
  }
}
