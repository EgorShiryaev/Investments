import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../components/forms/login_form.dart';
import '../../components/link.dart';
import '../../components/page_wrapper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginPage({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
        pageTitle: 'Войдите',
        pageSubtitle: 'для того чтобы продолжить',
        children: [
          LoginForm(
            emailController: emailController,
            passwordController: passwordController,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text(
                  'У вас нет аккаунта?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Link(
                  text: 'Зарегистрироваться',
                  onPress: BlocProvider.of<AuthNavigationCubit>(context)
                      .navigateToSignUp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
