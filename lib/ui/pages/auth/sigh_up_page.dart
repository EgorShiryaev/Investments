import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../components/forms/sign_up_form.dart';
import '../../components/link.dart';
import '../../components/page_wrapper.dart';

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
    return Scaffold(
      body: PageWrapper(
        pageTitle: 'Регистрация',
        children: [
          SignUpForm(
            fullNameController: widget.fullNameController,
            emailController: widget.emailController,
            passwordController: widget.passwordController,
            confirmPasswordController: widget.confirmPasswordController,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'У вас уже есть аккаунт?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Link(
                  text: 'Войти в аккаунт',
                  onPress: navigateToLogin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
