import 'package:flutter/material.dart';

class DismissibleWrapper extends StatelessWidget {
  final String uniqKey;
  final Widget child;
  final void Function() onRightSwipe;

  const DismissibleWrapper({
    super.key,
    required this.uniqKey,
    required this.child,
    required this.onRightSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(uniqKey),
      direction: DismissDirection.endToStart,
      background: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Удалить',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.red),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onRightSwipe();
        }
      },
      child: child,
    );
  }
}
