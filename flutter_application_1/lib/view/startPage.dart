import 'package:flutter/material.dart';
import 'package:tubes/component/cardButton.dart';
import 'package:tubes/utilities/constant.dart';
import 'package:tubes/view/login.dart';
import 'package:tubes/view/register.dart';

class StartPageView extends StatelessWidget {
  const StartPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Image.asset('images/logo1.png'),
            ),
            Text("Selamat datang, silahkan : ", style: textStyle1),
            CardButton(
              icon: Icons.app_registration_sharp,
              text: 'Register',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterView()),
                );
              },
            ),
            Text("Atau", style: textStyle2),
            CardButton(
              icon: Icons.login,
              text: 'Login',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
