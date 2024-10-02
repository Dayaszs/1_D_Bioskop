import 'package:flutter/material.dart';
import 'package:1_D_Bioskop/view/startPage.dart';
import 'package:tubes/view/login.dart';
import 'package:tubes/view/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartPageView(),
    );
  }
}
