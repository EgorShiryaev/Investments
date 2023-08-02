import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_navigation_cubit/auth_navigation_cubit.dart';
import 'modal_action.dart';

class UserNotFoundModal extends StatefulWidget {
  final void Function() navigateToSignUp;
  const UserNotFoundModal({super.key, required this.navigateToSignUp});

  static void show(BuildContext context) {
    unawaited(
      showDialog(
        context: context,
        builder: (_) => UserNotFoundModal(
          navigateToSignUp: () {
            BlocProvider.of<AuthNavigationCubit>(context).navigateToSignUp();
          },
        ),
      ),
    );
  }

  @override
  State<UserNotFoundModal> createState() => _UserNotFoundModalState();
}

class _UserNotFoundModalState extends State<UserNotFoundModal> {
  void hideModal() {
    Navigator.pop(context);
  }

  void navigateToSignUp() {
    hideModal();
    widget.navigateToSignUp();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Пользователь с такими данными не найден'),
      content: const Text('Перейти на страницу регистрации?'),
      actions: <Widget>[
        ModalAction(text: 'Да', onPress: navigateToSignUp),
        ModalAction(text: 'Нет', onPress: hideModal),
      ],
    );
  }
}
