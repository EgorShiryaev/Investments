import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../components/auth/forms/login_form.dart';
import '../../components/auth/text_with_link.dart';
import '../../components/wrappers/page_wrapper.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginPage({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void navigateToSignUpPage() {
    BlocProvider.of<AuthNavigationCubit>(context).navigateToSignUp();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Войдите',
      pageSubtitle: 'для того чтобы продолжить',
      children: [
        LoginForm(
          emailController: widget.emailController,
          passwordController: widget.passwordController,
        ),
        TextWithLink(
          linkText: 'Зарегистрироваться',
          onPressLink: navigateToSignUpPage,
          text: 'У вас нет аккаунта?',
        ),
      ],
    );
  }
}
