import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/login_data.dart';
import '../../blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../blocs/login_cubit/login_cubit.dart';
import '../../blocs/login_cubit/login_state.dart';
import '../../blocs/user_auth_cubit/user_auth_cubit.dart';
import '../forms/login_form.dart';
import '../link.dart';
import '../loading_indicator.dart';
import '../modals/error_modal.dart';
import '../modals/user_not_found_modal.dart';
import 'form_wrapper.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginView({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
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
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoadingLoginState) {
            return const LoadingIndicator();
          }
          return FormWrapper(
            children: [
              Text(
                'Войдите',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                'для того чтобы продолжить',
                style: Theme.of(context).textTheme.headlineMedium,
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
    );
  }
}
