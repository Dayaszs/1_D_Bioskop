import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/login.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: lightColor,
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register", style: textStyle3),
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Username tidak boleh kosong!';
                  }

                  return null;
                },
                    controller: usernameController,
                    hintTxt: "username",
                    helperTxt: "Username",
                    iconData: Icons.person),
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Password tidak boleh kosong!';
                  }

                  if (p0.length < 8) {
                    return 'Password minimal 8 digit';
                  }

                  return null;
                },
                    controller: passwordController,
                    hintTxt: "********",
                    helperTxt: "Password",
                    iconData: Icons.password,
                    password: true),
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Email tidak boleh kosong!';
                  }

                  if (!p0.contains('@')) {
                    return 'Email harus menggunakan @';
                  }

                  return null;
                },
                    controller: emailController,
                    hintTxt: "user@gmail.com",
                    helperTxt: "Email",
                    iconData: Icons.mail),
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong!';
                  }

                  return null;
                },
                    controller: nomorTeleponController,
                    hintTxt: "XXXXXXXXXXXX",
                    helperTxt: "Phone Number",
                    iconData: Icons.phone),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;
                          formData['email'] = emailController.text;
                          formData['nomor_telepon'] = nomorTeleponController.text;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginView(data: formData,)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightColor,
                        minimumSize: Size(350, 50),
                        
                      ),
                      child: const Text('Register', style: textStyle4,))

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
