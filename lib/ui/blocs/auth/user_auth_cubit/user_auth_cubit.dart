import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_variables.dart';
import '../../../../logic/models/login_data.dart';
import '../../../../logic/models/user.dart';
import '../../../../logic/usecases/auth_usecases.dart';
import '../../../../logic/usecases/previous_login_data_usecases.dart';
import '../../../../logic/utils/crypto_utils.dart';
import 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  final PreviousLoginDataUsecases _previousLoginDataUsecases;
  final AuthUsecases _authUsecases;

  UserAuthCubit({
    required PreviousLoginDataUsecases previousLoginDataUsecases,
    required AuthUsecases authUsecases,
  })  : _previousLoginDataUsecases = previousLoginDataUsecases,
        _authUsecases = authUsecases,
        super(InitialUserAuthState());

 

  void checkUserAuthState() {
    unawaited(
      _previousLoginDataUsecases.previousLoginData.then((value) {
        if (value == null) {
          emit(UserIsNotAuth());
          return;
        }

        final loginData = LoginData(
          email: value.email,
          password: hashingPassword(value.password),
        );

        _authUsecases.login(loginData).then((value) {
          currentUser = value;
          emit(UserIsAuth());
        }).catchError((_) {
          emit(AutologinFailureAuthState(loginData: value));
        });
      }).catchError((error) {
        emit(UserIsNotAuth());
      }),
    );
  }

  void auth(LoginData loginData, User userData) {
    currentUser = userData;
    emit(UserIsAuth());
    unawaited(_previousLoginDataUsecases.saveLoginData(loginData));
  }

  void logOut() {
    currentUser = null;
    emit(UserIsNotAuth());
    unawaited(_previousLoginDataUsecases.deleteSavedLoginData());
  }
}
