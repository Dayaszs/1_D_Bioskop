import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/user.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:flutter_application_1/view/home.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: lightColor,
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login", style: textStyle3),
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
                Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (dataForm!['email'] == emailController.text &&
                                dataForm['password'] ==
                                    passwordController.text) {
                              loginSuccess(context);
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Password Salah'),
                                  content: TextButton(
                                      onPressed: () => {},
                                      child: const Text('Silahkan coba login kembali!')),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightColor,
                          minimumSize: Size(350, 50),
                        ),
                        child: const Text(
                          'Login',
                          style: textStyle4,
                        ))),
                TextButton(
                      onPressed: () {
                        Map<String, dynamic> formData = {};
                        formData['email'] = emailController.text;
                        formData['password'] = passwordController.text;
                        createAccount(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Belum punya akun ?', style: textStyle5),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeView(),
      ),
    );
  }

  void createAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }
}
