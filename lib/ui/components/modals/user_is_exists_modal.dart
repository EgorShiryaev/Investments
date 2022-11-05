import 'package:flutter/material.dart';

import 'modal_action.dart';

class UserIsExistsModal extends StatefulWidget {
  const UserIsExistsModal({super.key});

  @override
  State<UserIsExistsModal> createState() => _UserIsExistsModalState();
}

class _UserIsExistsModalState extends State<UserIsExistsModal> {
  void navigateToLoginScreen() {
    hideModal();
    Navigator.pop(context);
  }

  void hideModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Пользователь с таким email уже зарегистрирован'),
      content: const Text('Перейти на страницу входа в аккаунт?'),
      actions: <Widget>[
        ModalAction(
          text: 'Да',
          onPress: navigateToLoginScreen,
        ),
        ModalAction(
          text: 'Нет',
          onPress: hideModal,
        ),
      ],
    );
  }
}
