import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/login_data.dart';
import '../../blocs/auth_navigation_cubit/auth_navigation_cubit.dart';
import '../../blocs/sign_up_cubit/sign_up_cubit.dart';
import '../../blocs/sign_up_cubit/sign_up_state.dart';
import '../../blocs/user_auth_cubit/user_auth_cubit.dart';
import '../forms/sign_up_form.dart';
import '../link.dart';
import '../loading_indicator.dart';
import '../modals/error_modal.dart';
import '../modals/user_is_exists_modal.dart';
import 'form_wrapper.dart';

class SignUpView extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpView({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  void navigateToLogin() {
    widget.passwordController.text = '';
    BlocProvider.of<AuthNavigationCubit>(context).navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is FailureSignUpState) {
          ErrorModal.show(context, message: state.message);
          widget.confirmPasswordController.text = '';
        } else if (state is UserIsExistsSignUpState) {
          UserIsExistsModal.show(context);
          widget.confirmPasswordController.text = '';
        } else if (state is SuccessSignUpState) {
          final loginData = LoginData(
            email: widget.emailController.text,
            password: widget.passwordController.text,
          );
          BlocProvider.of<UserAuthCubit>(context).auth(loginData, state.user);
        }
      },
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          if (state is LoadingSignUpState) {
            return const LoadingIndicator();
          }
          return FormWrapper(
            children: [
              Text(
                'Регистрация',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              SignUpForm(
                fullNameController: widget.fullNameController,
                emailController: widget.emailController,
                passwordController: widget.passwordController,
                confirmPasswordController: widget.confirmPasswordController,
              ),
              const SizedBox(height: 20),
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
          );
        },
      ),
    );
  }
}
