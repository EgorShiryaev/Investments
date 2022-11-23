import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'ui/bloc_views/auth/user_auth_cubit_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investments',
      theme: AppTheme().light,
      home: const UserAuthCubitView(),
    );
  }
}
