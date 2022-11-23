import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_navigation_state.dart';

class AuthNavigationCubit extends Cubit<AuthNavigationState> {
  AuthNavigationCubit() : super(LoginNavigationState());

  void navigateToLogin() {
    emit(LoginNavigationState());
  }

  void navigateToSignUp() {
    emit(SignUpNavigationState());
  }
}
