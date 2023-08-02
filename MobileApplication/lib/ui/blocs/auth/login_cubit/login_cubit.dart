import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/exceptions/api_exceptions.dart';
import '../../../../logic/models/login_data.dart';
import '../../../../logic/usecases/auth_usecases.dart';
import '../../../../logic/utils/crypto_utils.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthUsecases _authUsecases;
  LoginCubit({
    required AuthUsecases authUsecases,
  })  : _authUsecases = authUsecases,
        super(InitialLoginState());

  void login({required String email, required String password}) {
    emit(LoadingLoginState());
    final loginData = LoginData(
      email: email,
      password: hashingPassword(password),
    );

    unawaited(
      _authUsecases.login(loginData).then((value) {
        emit(SuccessLoginState(user: value));
      }).catchError((error) {
        if (error is ItemNotFoundException) {
          emit(UserNotFoundLoginState());
        } else if (error is ParameterNotFoundException) {
          emit(FailureLoginState(message: error.errors.join('\n')));
        } else {
          emit(FailureLoginState(message: error.toString()));
        }
      }),
    );
  }
}
