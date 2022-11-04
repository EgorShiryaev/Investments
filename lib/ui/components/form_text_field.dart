import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String label;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String? value)? onFieldSubmitted;

  const FormTextField({
    super.key,
    required this.label,
    this.obscureText,
    this.validator,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.onFieldSubmitted,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool isFocused = false;
  bool isHidden = false;

  @override
  void initState() {
    isHidden = widget.obscureText ?? false;
    super.initState();
  }

  // ignore: avoid_positional_boolean_parameters
  void changeIsFocus(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }

  void changeIsVisible() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void focusNextField() {
    if (widget.nextFocusNode == null) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(widget.nextFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: Theme.of(context).colorScheme.background,
        elevation: isFocused ? 10 : 0,
        child: Focus(
          onFocusChange: changeIsFocus,
          child: TextFormField(
            decoration: InputDecoration(
              label: Text(widget.label),
              suffixIcon: widget.obscureText != true
                  ? null
                  : IconButton(
                      icon: Icon(
                          isHidden ? Icons.visibility : Icons.visibility_off),
                      onPressed: changeIsVisible,
                    ),
            ),
            onEditingComplete: focusNextField,
            onFieldSubmitted: widget.onFieldSubmitted,
            focusNode: widget.focusNode,
            obscureText: isHidden,
            validator: widget.validator,
            controller: widget.controller,
          ),
        ),
      ),
    );
  }
}
