import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/models/login_data.dart';
import '../../blocs/auth/sign_up_cubit/sign_up_state.dart';
import '../../blocs/index.dart';
import '../../components/modals/error_modal.dart';
import '../../components/modals/user_is_exists_modal.dart';
import '../../pages/auth/loading_page.dart';
import '../../pages/auth/sigh_up_page.dart';

class SignUpCubitView extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpCubitView({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  void listener(BuildContext context, SignUpState state) {
    if (state is FailureSignUpState) {
      ErrorModal.show(context, message: state.message);
      confirmPasswordController.text = '';
    } else if (state is UserIsExistsSignUpState) {
      UserIsExistsModal.show(context);
      confirmPasswordController.text = '';
    } else if (state is SuccessSignUpState) {
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
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: listener,
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state is LoadingSignUpState) {
              return const LoadingPage();
            }
            return SignUpPage(
              fullNameController: fullNameController,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
            );
          },
        ),
      ),
    );
  }
}
