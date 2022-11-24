import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection.dart';
import '../../../logic/models/login_data.dart';
import '../../blocs/auth/auth_navigation_cubit/auth_navigation_state.dart';
import '../../blocs/index.dart';
import '../../components/unknowed_bloc_state_view.dart';
import 'login_cubit_view.dart';
import 'sign_up_cubit_view.dart';

class AuthNavigationCubitView extends StatefulWidget {
  final LoginData? previousLoginData;
  const AuthNavigationCubitView({super.key, required this.previousLoginData});

  @override
  State<AuthNavigationCubitView> createState() =>
      _AuthNavigationCubitViewState();
}

class _AuthNavigationCubitViewState extends State<AuthNavigationCubitView> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool previousLoginDataIsSetted = false;

  void modalNavigateToLogin() {
    passwordController.text = '';
  }

  void setPreviousLoginData() {
    if (widget.previousLoginData != null && !previousLoginDataIsSetted) {
      emailController.text = widget.previousLoginData!.email;
      passwordController.text = widget.previousLoginData!.password;
      previousLoginDataIsSetted = true;
    }
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
        ),
      ],
      child: BlocBuilder<AuthNavigationCubit, AuthNavigationState>(
        builder: (context, state) {
          if (state is LoginNavigationState) {
            return LoginCubitView(
              emailController: emailController,
              passwordController: passwordController,
            );
          } else if (state is SignUpNavigationState) {
            return SignUpCubitView(
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              fullNameController: fullNameController,
            );
          }
          return const Scaffold(body: UnknowedfBlocStateView());
        },
      ),
    );
  }
}
