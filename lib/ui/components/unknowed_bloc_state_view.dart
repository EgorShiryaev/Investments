import 'package:flutter/material.dart';

class UnknowedfBlocStateView extends StatelessWidget {
  const UnknowedfBlocStateView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: ColoredBox(
        color: colorScheme.error,
        child: SizedBox(
          height: 200,
          child: Center(
            child: Text(
              'UNKNOWED STATE',
              style: TextStyle(
                color: colorScheme.onError,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
