import 'package:flutter/material.dart';

import 'separator.dart';
import 'subtitle.dart';

class InstrumentTypeView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const InstrumentTypeView({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Subtitle(text: title),
        const Separator(height: 10),
        ...children,
        const Separator(height: 10),
      ],
    );
  }
}
