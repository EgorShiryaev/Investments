import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme.dart';
import 'dependency_injection.dart';
import 'ui/blocs/auth_cubit/auth_cubit.dart';
import 'ui/modules/auth_module.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<AuthCubit>();
        unawaited(cubit.checkUserLoggedEarlier());
        return cubit;
      },
      child: MaterialApp(
        title: 'Investments',
        theme: AppTheme().light,
        home: const AuthModule(),
      ),
    );
  }
}
