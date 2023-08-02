import '../../../../logic/models/user.dart';

abstract class SignUpState {}

class InitialSignUpState extends SignUpState {}

class LoadingSignUpState extends SignUpState {}

class SuccessSignUpState extends SignUpState {
  final User user;

  SuccessSignUpState({required this.user});
}

class FailureSignUpState extends SignUpState {
  final String message;

  FailureSignUpState({
    required this.message,
  });
}

class UserIsExistsSignUpState extends SignUpState {}
