import '../../../../logic/models/login_data.dart';

abstract class UserAuthState {}

class InitialUserAuthState extends UserAuthState {}

class UserIsAuth extends UserAuthState {}

class UserIsNotAuth extends UserAuthState {}

class AutologinFailureAuthState extends UserAuthState {
  final LoginData loginData;

  AutologinFailureAuthState({required this.loginData});
}
