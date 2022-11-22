import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/login_data.dart';
import '../../../logic/models/user.dart';
import '../../../logic/usecases/auth_usecases.dart';
import '../../../logic/usecases/previous_login_data_usecases.dart';
import '../../../logic/utils/crypto_utils.dart';
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

  User? _user;

  User? get user => _user;

  Future<void> checkUserAuthState() async {
    final previousLoginData =
        await _previousLoginDataUsecases.previousLoginData.catchError((error) {
      emit(UserIsNotAuth());
    });

    if (previousLoginData == null) {
      emit(UserIsNotAuth());
      return;
    }

    final loginData = LoginData(
      email: previousLoginData.email,
      password: hashingPassword(previousLoginData.password),
    );

    await _authUsecases.login(loginData).then((value) {
      _user = value;
      emit(UserIsAuth());
    }).catchError((_) {
      emit(AutologinFailureAuthState(loginData: previousLoginData));
    });
  }

  void auth(LoginData loginData, User userData) {
    _user = userData;
    emit(UserIsAuth());
    unawaited(_previousLoginDataUsecases.saveLoginData(loginData));
  }

  void logOut() {
    _user = null;
    emit(UserIsNotAuth());
    unawaited(_previousLoginDataUsecases.deleteSavedLoginData());
  }
}
