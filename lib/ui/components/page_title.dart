import 'package:flutter/material.dart';

import 'subtitle.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? titleAction;

  const PageTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.titleAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            if (titleAction != null) titleAction!
          ],
        ),
        if (subtitle != null)
          Subtitle(
            text: subtitle!,
          )
      ],
    );
  }
}
