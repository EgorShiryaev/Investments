import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/login_data.dart';
import '../../blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../blocs/login_cubit/login_cubit.dart';
import '../../blocs/login_cubit/login_state.dart';
import '../../blocs/user_auth_cubit/user_auth_cubit.dart';
import '../../components/forms/login_form.dart';
import '../../components/link.dart';
import '../../components/loading_indicator.dart';
import '../../components/modals/error_modal.dart';
import '../../components/modals/user_not_found_modal.dart';
import '../../components/page_wrapper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginPage({
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
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: listener,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoadingLoginState) {
              return const LoadingIndicator();
            }
            return PageWrapper(
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
            );
          },
        ),
      ),
    );
  }
}
