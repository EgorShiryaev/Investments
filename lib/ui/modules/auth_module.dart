import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection.dart';
import '../../logic/models/login_data.dart';
import '../blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../blocs/auth_navigation_cubit/auth_navigation_state.dart';
import '../blocs/login_cubit/login_cubit.dart';
import '../blocs/sign_up_cubit/sign_up_cubit.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/sigh_up_page.dart';

class AuthModule extends StatefulWidget {
  final LoginData? previousLoginData;
  const AuthModule({super.key, required this.previousLoginData});

  @override
  State<AuthModule> createState() => _AuthModuleState();
}

class _AuthModuleState extends State<AuthModule> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool previousLoginDataIsSetted = false;

  void modalNavigateToLogin() {
    passwordController.text = '';
  }

  @override
  void initState() {
    if (widget.previousLoginData != null) {
      emailController.text = widget.previousLoginData!.email;
      passwordController.text = widget.previousLoginData!.password;
    }
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void setPreviousLoginData() {
    if (widget.previousLoginData != null && !previousLoginDataIsSetted) {
      emailController.text = widget.previousLoginData!.email;
      passwordController.text = widget.previousLoginData!.password;
      previousLoginDataIsSetted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    setPreviousLoginData();
    return MultiBlocProvider(
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
            return LoginPage(
              emailController: emailController,
              passwordController: passwordController,
            );
          } else if (state is SignUpNavigationState) {
            return SignUpPage(
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
    );
  }
}
