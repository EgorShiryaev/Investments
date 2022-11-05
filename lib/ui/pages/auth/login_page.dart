import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth_cubit/auth_cubit.dart';
import '../../blocs/auth_cubit/auth_state.dart';
import '../../components/forms/login_form.dart';
import '../../components/link.dart';
import '../../components/loading_indicator.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onPressRegistrationLink() {
    unawaited(
      Navigator.push(context, RegistrationPage.route),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          passwordController.text = '';
          if (state is LoadingState) {
            return const LoadingIndicator();
          }
          if (state is LoginSavedDataFailureState) {
            emailController.text = state.loginData.email;
            passwordController.text = state.loginData.password;
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: constraints.maxWidth * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Войдите',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            'для того чтобы продолжить',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 20),
                          LoginForm(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Text(
                                  'У вас нет аккаунта?',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Link(
                                  text: 'Зарегистрироваться',
                                  onPress: onPressRegistrationLink,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
