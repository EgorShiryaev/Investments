import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection.dart';
import '../../logic/models/login_data.dart';
import '../blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../blocs/auth_navigation_cubit/auth_navigation_state.dart';
import '../blocs/login_cubit/login_cubit.dart';
import '../blocs/sign_up_cubit/sign_up_cubit.dart';
import '../components/auth/login_view.dart';
import '../components/auth/sigh_up_view.dart';

class AuthPage extends StatefulWidget {
  final LoginData? previousLoginData;
  const AuthPage({super.key, required this.previousLoginData});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    if (widget.previousLoginData != null) {
      emailController.text = widget.previousLoginData!.email;
      passwordController.text = widget.previousLoginData!.password;
    }
    super.initState();
  }

  void modalNavigateToLogin() {
    passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => getIt<LoginCubit>(),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => getIt<SignUpCubit>(),
          ),
          BlocProvider<AuthNavigationCubit>(
            create: (context) => getIt<AuthNavigationCubit>(),
          )
        ],
        child: BlocBuilder<AuthNavigationCubit, AuthNavigationState>(
          builder: (context, state) {
            if (state is LoginNavigationState) {
              return LoginView(
                emailController: emailController,
                passwordController: passwordController,
              );
            } else if (state is SignUpNavigationState) {
              return SignUpView(
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                fullNameController: fullNameController,
              );
            }
            return const ColoredBox(
              color: Colors.red,
              child: Center(
                child: Text('Unknowed state'),
              ),
            );
          },
        ),
      ),
    );
  }
}
