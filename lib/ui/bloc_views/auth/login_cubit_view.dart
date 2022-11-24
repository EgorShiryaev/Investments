import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/login_data.dart';
import '../../blocs/auth/login_cubit/login_state.dart';
import '../../blocs/index.dart';
import '../../components/modals/error_modal.dart';
import '../../components/modals/user_not_found_modal.dart';
import '../../pages/auth/loading_page.dart';
import '../../pages/auth/login_page.dart';

class LoginCubitView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginCubitView({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  void listener(BuildContext context, LoginState state) {
    if (state is FailureLoginState) {
      ErrorModal.show(context, message: state.message);
      passwordController.text = '';
    } else if (state is UserNotFoundLoginState) {
      UserNotFoundModal.show(context);
      passwordController.text = '';
    } else if (state is SuccessLoginState) {
      final loginData = LoginData(
        email: emailController.text,
        password: passwordController.text,
      );
      BlocProvider.of<UserAuthCubit>(context).auth(loginData, state.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: listener,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoadingLoginState) {
            return const LoadingPage();
          }
          return LoginPage(
            emailController: emailController,
            passwordController: passwordController,
          );
        },
      ),
    );
  }
}
