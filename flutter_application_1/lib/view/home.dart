import 'package:flutter/material.dart';
import 'package:tubes/utilities/constant.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: lightColor,
        ),
        body: Center(
          child: Column(
            
          ),
        ),
      ),
    );
  }
}