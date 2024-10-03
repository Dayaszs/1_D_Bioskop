import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/user.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:flutter_application_1/view/startPage.dart';
import 'package:flutter_application_1/view/homeView.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}