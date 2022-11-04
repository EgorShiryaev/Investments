import '../models/login_data.dart';
import '../repositories/login_data_repository.dart';

class LoginDataUsecases {
  final LoginDataRepository _repository;

  LoginDataUsecases({
    required LoginDataRepository repository,
  }) : _repository = repository;

  Future<LoginData?> get previousLoginData => _repository.previousLoginData;

  Future<void> saveLoginData(LoginData loginData) {
    return _repository.saveLoginData(loginData);
  }

  Future<void> deleteSavedLoginData() {
    return _repository.deleteSavedLoginData();
  }
}
