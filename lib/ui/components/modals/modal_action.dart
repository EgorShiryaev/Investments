import 'package:flutter/material.dart';

class ModalAction extends StatelessWidget {
  final String text;
  final void Function() onPress;

  const ModalAction({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      onPressed: onPress,
      child: Text(text),
    );
  }
}
