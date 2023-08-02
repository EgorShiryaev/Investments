import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/exceptions/api_exceptions.dart';
import '../../../../logic/models/login_data.dart';
import '../../../../logic/usecases/auth_usecases.dart';
import '../../../../logic/utils/crypto_utils.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthUsecases _authUsecases;

  SignUpCubit({
    required AuthUsecases authUsecases,
  })  : _authUsecases = authUsecases,
        super(InitialSignUpState());

  void signUp({required String email, required String password}) {
    emit(LoadingSignUpState());
    final loginData = LoginData(
      email: email,
      password: hashingPassword(password),
    );

    unawaited(
      _authUsecases.signUp(loginData).then((value) {
        emit(SuccessSignUpState(user: value));
      }).catchError((error) {
        if (error is ItemIsExistsException) {
          emit(UserIsExistsSignUpState());
        } else if (error is ParameterNotFoundException) {
          emit(FailureSignUpState(message: error.errors.join('\n')));
        } else {
          emit(FailureSignUpState(message: error.toString()));
        }
      }),
    );
  }
}
