import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/startPage.dart';

class LoginView extends StatefulWidget {
  final Map<String, dynamic>? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  Map<String, dynamic>? dataForm;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dataForm = widget.data;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: lightColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StartPageView()),
              );
            },
          ),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login", style: textStyle3),
                inputForm(
                  (p0) {
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
                  iconData: Icons.mail,
                ),
                inputForm(
                  (p0) {
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
                  password: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (dataForm != null &&
                            dataForm!['email'] == emailController.text &&
                            dataForm!['password'] == passwordController.text) {
                          loginSuccess(context, dataForm!);
                        } else {
                          showLoginError(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightColor,
                      minimumSize: const Size(350, 50),
                    ),
                    child: const Text(
                      'Login',
                      style: textStyle4,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    createAccount(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Belum punya akun ?', style: textStyle5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginSuccess(BuildContext context, Map<String, dynamic> userData) {
    print("Navigating to Home with data: $userData");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeView(userData: userData),
      ),
    );
  }

  void showLoginError(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Gagal'),
        content: const Text('Email atau password salah. Silahkan coba lagi.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
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
