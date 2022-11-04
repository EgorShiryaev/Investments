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
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.apply(
                color: Theme.of(context).colorScheme.tertiary,
              ),
        ),
      ),
    );
  }
}
