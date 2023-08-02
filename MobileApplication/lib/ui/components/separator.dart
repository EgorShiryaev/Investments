import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double? height;
  const Separator({super.key, this.height});

  static const defaultHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? defaultHeight,
    );
  }
}
