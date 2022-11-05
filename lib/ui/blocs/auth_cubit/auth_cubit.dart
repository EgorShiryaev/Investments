import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/exceptions/api_exceptions.dart';
import '../../../logic/models/login_data.dart';
import '../../../logic/usecases/login_data_usecases.dart';
import '../../../logic/usecases/user_usecases.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginDataUsecases _loginDataUsecases;
  final UserUsecases _userUsecases;

  AuthCubit({
    required LoginDataUsecases loginDataUsecases,
    required UserUsecases userUsecases,
  })  : _loginDataUsecases = loginDataUsecases,
        _userUsecases = userUsecases,
        super(UnknownState());

  Future<void> checkUserLoggedEarlier() async {
    final previousLoginData = await _loginDataUsecases.previousLoginData;

    if (previousLoginData == null) {
      emit(NotAuthorizedState());
      return;
    }

    await _userUsecases.login(previousLoginData).then((value) {
      emit(AuthorizedState(user: value));
    }).catchError((_) {
      emit(LoginSavedDataFailureState(loginData: previousLoginData));
    });
  }

  Future<void> login(LoginData data) async {
    emit(LoadingState());
    await _userUsecases.login(data).then((value) {
      emit(AuthorizedState(user: value));
      _loginDataUsecases.saveLoginData(data);
    }).catchError(_handleErrors);
  }

  Future<void> signUp(LoginData data) async {
    emit(LoadingState());
    await _userUsecases.signUp(data).then((value) {
      emit(AuthorizedState(user: value));
      _loginDataUsecases.saveLoginData(data);
    }).catchError(_handleErrors);
  }

  Future<void> logout() async {
    emit(LoadingState());
    await _loginDataUsecases.deleteSavedLoginData();
    emit(NotAuthorizedState());
  }

  // ignore: prefer_void_to_null
  FutureOr<Null> _handleErrors(e) {
    log(e.toString());
    if (e is ItemNotFoundException) {
      emit(UserNotFoundState());
    } else if (e is ItemIsExistsException) {
      emit(UserIsExistsState());
    } else if (e is ServerErrorException) {
      emit(ErrorState(message: e.message));
    } else if (e is ParameterNotFoundException) {
      emit(ErrorState(message: e.errors.join('\n')));
    } else {
      emit(ErrorState(message: e.toString()));
    }
  }
}
