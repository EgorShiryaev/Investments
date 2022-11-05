import 'dart:async';

import 'package:flutter/material.dart';

import '../../pages/auth/registration_page.dart';
import 'modal_action.dart';

class UserNotFoundModal extends StatefulWidget {
  const UserNotFoundModal({super.key});

  @override
  State<UserNotFoundModal> createState() => _UserNotFoundModalState();
}

class _UserNotFoundModalState extends State<UserNotFoundModal> {
  void navigateToRegistrationScreen() {
    hideModal();
    unawaited(
      Navigator.push(context, RegistrationPage.route),
    );
  }

  void hideModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Пользователь с такими данными не найден'),
      content: const Text('Перейти на страницу регистрации?'),
      actions: <Widget>[
        ModalAction(
          text: 'Да',
          onPress: navigateToRegistrationScreen,
        ),
        ModalAction(
          text: 'Нет',
          onPress: hideModal,
        ),
      ],
    );
  }
}
