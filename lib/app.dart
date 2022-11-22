import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_theme.dart';
import 'dependency_injection.dart';
import 'logic/models/login_data.dart';
import 'ui/blocs/user_auth_cubit/user_auth_cubit.dart';
import 'ui/blocs/user_auth_cubit/user_auth_state.dart';
import 'ui/modules/auth_module.dart';
import 'ui/pages/home_tab_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investments',
      theme: AppTheme().light,
      home: BlocProvider<UserAuthCubit>(
        create: (context) {
          final cubit = getIt<UserAuthCubit>();
          unawaited(cubit.checkUserAuthState());
          return cubit;
        },
        child: BlocListener<UserAuthCubit, UserAuthState>(
          listener: (context, state) {
            if (state is! InitialUserAuthState) {
              FlutterNativeSplash.remove();
            }
          },
          child: BlocBuilder<UserAuthCubit, UserAuthState>(
            builder: (context, state) {
              LoginData? loginData;
              if (state is UserIsAuth) {
                return const HomeTabsPage();
              } else if (state is AutologinFailureAuthState) {
                loginData = state.loginData;
              }
              return AuthModule(previousLoginData: loginData);
            },
          ),
        ),
      ),
    );
  }
}
