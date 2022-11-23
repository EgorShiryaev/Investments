import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_navigation_cubit/auth_navigation_cubit.dart';
import 'modal_action.dart';

class UserIsExistsModal extends StatefulWidget {
  final void Function() navigateToLogin;
  const UserIsExistsModal({super.key, required this.navigateToLogin});

  static void show(BuildContext context) {
    unawaited(
      showDialog(
        context: context,
        builder: (_) => UserIsExistsModal(
          navigateToLogin: () {
            BlocProvider.of<AuthNavigationCubit>(context).navigateToLogin();
          },
        ),
      ),
    );
  }

  @override
  State<UserIsExistsModal> createState() => _UserIsExistsModalState();
}

class _UserIsExistsModalState extends State<UserIsExistsModal> {
  void hideModal() {
    Navigator.pop(context);
  }

  void navigateToSignUp() {
    hideModal();
    widget.navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Пользователь с таким email уже зарегистрирован'),
      content: const Text('Перейти на страницу входа в аккаунт?'),
      actions: <Widget>[
        ModalAction(text: 'Да', onPress: navigateToSignUp),
        ModalAction(text: 'Нет', onPress: hideModal),
      ],
    );
  }
}
