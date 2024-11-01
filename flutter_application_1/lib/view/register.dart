import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/formComponent.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/data/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  File? _profileImage;
  bool _isImageErrorVisible = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final directory = await getApplicationDocumentsDirectory();
      final File image = File(pickedImage.path);
      final String newPath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await image.copy(newPath);
      setState(() {
        _profileImage = File(newPath);
        _isImageErrorVisible = false;
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih sumber gambar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Kamera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/placeholder.png') as ImageProvider,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
                if (_isImageErrorVisible)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Profile Pic Wajib Diisi!",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 10),
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
                        if (_profileImage == null) {
                          setState(() {
                            _isImageErrorVisible = true;
                          });
                        } else {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;
                          formData['email'] = emailController.text;
                          formData['nomor_telepon'] =
                              nomorTeleponController.text;
                          formData['profile_image'] = _profileImage!.path;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginView(data: formData),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightColor,
                      minimumSize: Size(350, 50),
                    ),
                    child: const Text('Register', style: textStyle4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
