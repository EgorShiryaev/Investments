import '../models/login_data.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthUsecases {
  final AuthRepository _authRepository;

  AuthUsecases({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<User> login(LoginData data) {
    return _authRepository.login(data);
  }

  Future<User> signUp(LoginData data) {
    return _authRepository.signUp(data);
  }
}
