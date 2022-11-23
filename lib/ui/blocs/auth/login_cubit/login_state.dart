import '../../../../logic/models/user.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final User user;

  SuccessLoginState({required this.user});
}

class FailureLoginState extends LoginState {
  final String message;

  FailureLoginState({
    required this.message,
  });
}

class UserNotFoundLoginState extends LoginState {}
