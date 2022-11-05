import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  final List<Widget> children;
  const FormWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
