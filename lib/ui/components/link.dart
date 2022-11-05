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
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(4),
        overlayColor: MaterialStateProperty.all(tertiaryColor.withOpacity(0.2)),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: tertiaryColor),
          ),
        ),
      ),
    );
  }
}
