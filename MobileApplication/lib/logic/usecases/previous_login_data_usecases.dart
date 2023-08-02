import '../models/login_data.dart';
import '../repositories/previous_login_data_repository.dart';

class PreviousLoginDataUsecases {
  final PreviousLoginDataRepository _previousLoginDataRepository;

  PreviousLoginDataUsecases({
    required PreviousLoginDataRepository previousLoginDataRepository,
  }) : _previousLoginDataRepository = previousLoginDataRepository;

  Future<LoginData?> get previousLoginData =>
      _previousLoginDataRepository.previousLoginData;

  Future<void> saveLoginData(LoginData loginData) {
    return _previousLoginDataRepository.save(loginData);
  }

  Future<void> deleteSavedLoginData() {
    return _previousLoginDataRepository.delete();
  }
}
