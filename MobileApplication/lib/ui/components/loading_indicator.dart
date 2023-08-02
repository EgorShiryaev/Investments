import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Size? _size;
  const LoadingIndicator({super.key, Size? size})
      : _size = size ?? const Size.fromHeight(500);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: _size,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
