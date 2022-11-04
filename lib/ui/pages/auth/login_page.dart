import 'dart:async';

import 'package:flutter/material.dart';
import '../../components/forms/login_form.dart';
import '../../components/link.dart';
import 'registration_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  void onPressRegistrationLink() {
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const RegistrationPage();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Войдите',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'для того чтобы продолжить',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 20),
                  const LoginForm(),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          'У вас нет аккаунта?',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Link(
                          text: 'Зарегистрироваться',
                          onPress: onPressRegistrationLink,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
