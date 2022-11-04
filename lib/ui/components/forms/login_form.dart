import 'package:flutter/material.dart';

import '../../../logic/utils/validator.dart';
import '../form_text_field.dart';
import 'form_wrapper.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void submit() {
    final formIsValid = formKey.currentState?.validate();
    if (formIsValid ?? false) {}
  }

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      formKey: formKey,
      fields: [
        FormTextField(
          label: 'Email',
          validator: validateEmailField,
          controller: emailController,
          focusNode: emailFocusNode,
          nextFocusNode: passwordFocusNode,
        ),
        FormTextField(
          label: 'Пароль',
          obscureText: true,
          controller: passwordController,
          validator: validatePasswordField,
          focusNode: passwordFocusNode,
          onFieldSubmitted: (_) => submit(),
        ),
      ],
      onSubmit: submit,
    );
  }
}
