import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
