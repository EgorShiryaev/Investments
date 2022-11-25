import 'package:flutter/material.dart';

import 'link.dart';

class TextWithLink extends StatelessWidget {
  final String text;
  final String linkText;
  final void Function() onPressLink;

  const TextWithLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onPressLink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Link(
          text: linkText,
          onPress: onPressLink,
        ),
      ],
    );
  }
}
