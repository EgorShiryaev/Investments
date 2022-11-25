import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  final String text;
  final Function() onPress;

  const Link({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tertiaryColor = theme.colorScheme.tertiary;
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(4),
      overlayColor: MaterialStateProperty.all(tertiaryColor.withOpacity(0.2)),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.apply(color: tertiaryColor),
        ),
      ),
    );
  }
}
