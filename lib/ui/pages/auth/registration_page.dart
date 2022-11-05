import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_cubit/auth_cubit.dart';
import '../../blocs/auth_cubit/auth_state.dart';
import '../../components/forms/registrarion_form.dart';
import '../../components/link.dart';
import '../../components/loading_indicator.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static MaterialPageRoute get route {
    return MaterialPageRoute(
      builder: (context) {
        return const RegistrationPage();
      },
    );
  }

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void goBackToLoginPage() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          confirmPasswordController.text = '';
          if (state is LoadingState) {
            return const LoadingIndicator();
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
                            'Регистрация',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 20),
                          RegistrationForm(
                            confirmPasswordController:
                                confirmPasswordController,
                            emailController: emailController,
                            fullNameController: fullNameController,
                            passwordController: passwordController,
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  'У вас уже есть аккаунт?',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Link(
                                  text: 'Войти в аккаунт',
                                  onPress: goBackToLoginPage,
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
