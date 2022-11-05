import 'package:flutter/material.dart';

import 'modal_action.dart';

class ErrorModal extends StatefulWidget {
  final String message;
  const ErrorModal({
    super.key,
    required this.message,
  });

  @override
  State<ErrorModal> createState() => _ErrorModalState();
}

class _ErrorModalState extends State<ErrorModal> {
  void hideModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Произошла ошибка'),
      content: Text(widget.message),
      actions: <Widget>[
        ModalAction(
          text: 'Понятно',
          onPress: hideModal,
        ),
      ],
    );
  }
}
