import '../../../logic/models/login_data.dart';
import '../../../logic/models/user.dart';

abstract class AuthState {}

class UnknownState extends AuthState {}

class NotAuthorizedState extends AuthState {}

class LoginSavedDataFailureState extends AuthState {
  final LoginData loginData;

  LoginSavedDataFailureState({required this.loginData});
}

class AuthorizedState extends AuthState {
  final User user;

  AuthorizedState({required this.user});
}

class UserNotFoundState extends AuthState {}

class UserIsExistsState extends AuthState {}

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});
}

class LoadingState extends AuthState {}
