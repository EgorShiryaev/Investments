import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'ui/modules/auth_module.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investments',
      theme: AppTheme().light,
      home: const AuthModule(),
    );
  }
}
