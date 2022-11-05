import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/models/login_data.dart';
import '../../../logic/utils/validator.dart';

import '../../blocs/auth_cubit/auth_cubit.dart';
import '../form_text_field.dart';
import 'form_wrapper.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final fullnameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    fullnameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void submit(BuildContext context) {
    final formIsValid = formKey.currentState?.validate();
    if (formIsValid ?? false) {
      unawaited(
        BlocProvider.of<AuthCubit>(context).signUp(
          LoginData(
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      formKey: formKey,
      fields: [
        FormTextField(
          label: 'Имя',
          validator: validateFullNameField,
          controller: fullNameController,
          focusNode: fullnameFocusNode,
          nextFocusNode: emailFocusNode,
          keyboardType: TextInputType.name,
        ),
        FormTextField(
          label: 'Email',
          controller: emailController,
          validator: validateEmailField,
          focusNode: emailFocusNode,
          nextFocusNode: passwordFocusNode,
          keyboardType: TextInputType.emailAddress,
        ),
        FormTextField(
          label: 'Пароль',
          obscureText: true,
          controller: passwordController,
          validator: validatePasswordField,
          focusNode: passwordFocusNode,
          nextFocusNode: confirmPasswordFocusNode,
          keyboardType: TextInputType.visiblePassword,
        ),
        FormTextField(
          label: 'Подтвердите пароль',
          obscureText: true,
          validator: (value) {
            return validateConfirmPasswordfField(
              value,
              passwordController.text,
            );
          },
          controller: confirmPasswordController,
          focusNode: confirmPasswordFocusNode,
          onFieldSubmitted: (_) => submit(context),
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
      onSubmit: () => submit(context),
    );
  }
}
