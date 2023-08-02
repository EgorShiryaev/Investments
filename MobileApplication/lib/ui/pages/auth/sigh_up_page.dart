import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../components/auth/forms/sign_up_form.dart';
import '../../components/auth/text_with_link.dart';
import '../../components/wrappers/page_wrapper.dart';

class SignUpPage extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpPage({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void navigateToLogin() {
    widget.passwordController.text = '';
    BlocProvider.of<AuthNavigationCubit>(context).navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Регистрация',
      children: [
        SignUpForm(
          fullNameController: widget.fullNameController,
          emailController: widget.emailController,
          passwordController: widget.passwordController,
          confirmPasswordController: widget.confirmPasswordController,
        ),
        TextWithLink(
          text: 'У вас уже есть аккаунт?',
          linkText: 'Войти в аккаунт',
          onPressLink: navigateToLogin,
        ),
      ],
    );
  }
}
