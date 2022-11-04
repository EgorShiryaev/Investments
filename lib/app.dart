import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'ui/pages/auth/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().light,
      home: const StartPage(),
    );
  }
}
