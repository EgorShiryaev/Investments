import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/utils/validator.dart';

import '../../../blocs/auth/sign_up_cubit/sign_up_cubit.dart';
import '../../form_text_field.dart';
import '../../wrappers/form_wrapper.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void submit() {
    final formIsValid = formKey.currentState?.validate();
    if (formIsValid ?? false) {
      BlocProvider.of<SignUpCubit>(context).signUp(
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
          label: 'Имя',
          validator: validateFullNameField,
          controller: widget.fullNameController,
          focusNode: fullNameFocusNode,
          nextFocusNode: emailFocusNode,
          keyboardType: TextInputType.name,
        ),
        FormTextField(
          label: 'Email',
          controller: widget.emailController,
          validator: validateEmailField,
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
          nextFocusNode: confirmPasswordFocusNode,
          keyboardType: TextInputType.visiblePassword,
        ),
        FormTextField(
          label: 'Подтвердите пароль',
          obscureText: true,
          validator: (value) {
            return validateConfirmPasswordfField(
              value,
              widget.passwordController.text,
            );
          },
          controller: widget.confirmPasswordController,
          focusNode: confirmPasswordFocusNode,
          onFieldSubmitted: (_) => submit(),
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
      onSubmit: submit,
    );
  }
}
