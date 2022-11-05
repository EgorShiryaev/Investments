import 'package:flutter/material.dart';

class FormWrapper extends StatefulWidget {
  final List<Widget> fields;
  final void Function() onSubmit;
  final GlobalKey<FormState> formKey;
  const FormWrapper({
    super.key,
    required this.fields,
    required this.onSubmit,
    required this.formKey,
  });

  @override
  State<FormWrapper> createState() => _FormWrapperState();
}

class _FormWrapperState extends State<FormWrapper> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void changeToAlwaysValidateMode() {
    if (autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...widget.fields,
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              changeToAlwaysValidateMode();
              widget.onSubmit();
            },
            child: const Text('Далее'),
          )
        ],
      ),
    );
  }
}
