import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../dependency_injection.dart';
import '../../logic/models/login_data.dart';
import '../blocs/user_auth_cubit/user_auth_cubit.dart';
import '../blocs/user_auth_cubit/user_auth_state.dart';
import '../pages/auth_page.dart';

class AuthModule extends StatefulWidget {
  const AuthModule({super.key});

  @override
  State<AuthModule> createState() => _AuthModuleState();
}

class _AuthModuleState extends State<AuthModule> {
  bool splashScreenIsVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAuthCubit>(
      create: (context) {
        final cubit = getIt<UserAuthCubit>();
        unawaited(cubit.checkUserAuthState());
        return cubit;
      },
      child: BlocBuilder<UserAuthCubit, UserAuthState>(
        builder: (context, state) {
          if (state is! UnknownUserAuthState && splashScreenIsVisible) {
            FlutterNativeSplash.remove();
            splashScreenIsVisible = false;
          }

          if (state is UserIsAuth) {
            final user = BlocProvider.of<UserAuthCubit>(context).user;
            return Scaffold(
              body: ColoredBox(
                color: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user!.uuid),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<UserAuthCubit>(context).logOut();
                        },
                        child: const Text('Выйти'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          LoginData? loginData;
          if (state is AutologinFailureAuthState) {
            loginData = state.loginData;
          }
          return AuthPage(previousLoginData: loginData);
        },
      ),
    );
  }
}
