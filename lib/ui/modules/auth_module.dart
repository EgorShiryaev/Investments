import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../dependency_injection.dart';
import '../../logic/utils/modal_utils.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import '../blocs/auth_cubit/auth_state.dart';
import '../components/modals/error_modal.dart';
import '../components/modals/user_not_found_modal.dart';
import '../pages/auth/login_page.dart';

class AuthModule extends StatefulWidget {
  const AuthModule({super.key});

  @override
  State<AuthModule> createState() => _AuthModuleState();
}

class _AuthModuleState extends State<AuthModule> {
  bool splashScreenIsHidden = false;

  void showUserNotFoundModal() {
    showModal(context, const UserNotFoundModal());
  }

  void showErrorModal(String message) {
    showModal(context, ErrorModal(message: message));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<AuthCubit>();
        unawaited(cubit.checkUserLoggedEarlier());
        return cubit;
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UserNotFoundState) {
            showUserNotFoundModal();
          } else if (state is ErrorState) {
            showErrorModal(state.message);
          }

          if ((state is NotAuthorizedState || state is AuthorizedState) &&
              !splashScreenIsHidden) {
            FlutterNativeSplash.remove();
            splashScreenIsHidden = true;
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthorizedState) {
              return const ColoredBox(color: Colors.red);
            } else if (state is UnknownState) {
              return const SizedBox();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
