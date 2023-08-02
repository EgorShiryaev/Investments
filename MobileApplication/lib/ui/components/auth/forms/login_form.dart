import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/utils/validator.dart';
import '../../../blocs/auth/login_cubit/login_cubit.dart';
import '../../form_text_field.dart';
import '../../wrappers/form_wrapper.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  void submit() {
    final formIsValid = formKey.currentState?.validate();
    if (formIsValid ?? false) {
      BlocProvider.of<LoginCubit>(context).login(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      formKey: formKey,
      fields: [
        FormTextField(
          label: 'Email',
          validator: validateEmailField,
          controller: widget.emailController,
          focusNode: emailFocusNode,
          nextFocusNode: passwordFocusNode,
          keyboardType: TextInputType.emailAddress,
        ),
        FormTextField(
          label: 'Пароль',
          obscureText: true,
          controller: widget.passwordController,
          validator: validatePasswordField,
          focusNode: passwordFocusNode,
          onFieldSubmitted: (_) => submit(),
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
      onSubmit: submit,
    );
  }
}
