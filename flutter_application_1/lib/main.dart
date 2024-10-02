import 'package:flutter/material.dart';
import 'package:tubes/view/startPage.dart';
import 'package:tubes/view/login.dart';
import 'package:tubes/view/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
 Dhiaz-branch
    return MaterialApp(
      home: const StartPageView(),
=======
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World! update'),
        ),
      ),
  main
    );
  }
}
