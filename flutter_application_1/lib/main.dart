import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/startPage.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/view/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPageView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
    );
  }
}
