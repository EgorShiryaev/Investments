import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String label;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final void Function(String? value)? onChange;
  final Widget? suffixIcon;

  const FormTextField({
    super.key,
    required this.label,
    this.obscureText,
    this.validator,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.onFieldSubmitted,
    this.keyboardType,
    this.onChange,
    this.suffixIcon,
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
    return Material(
      color: Theme.of(context).colorScheme.background,
      elevation: isFocused ? 10 : 0,
      child: Focus(
        onFocusChange: changeIsFocus,
        child: TextFormField(
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            label: Text(widget.label),
            suffixIcon: widget.obscureText ?? false
                ? IconButton(
                    icon: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: changeIsVisible,
                  )
                : widget.suffixIcon,
          ),
          onChanged: widget.onChange,
          onEditingComplete: focusNextField,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          obscureText: isHidden,
          validator: widget.validator,
          controller: widget.controller,
        ),
      ),
    );
  }
}
