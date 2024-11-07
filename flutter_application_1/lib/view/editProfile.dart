import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/view/profile.dart';

class EditProfileView extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditProfileView({Key? key, required this.data}) : super(key: key);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late Map<String, dynamic> data;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    data = Map<String, dynamic>.from(widget.data);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        data['profile_image'] = _imageFile?.path;
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.white),
                  title: const Text('Take a picture', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.white),
                  title: const Text('Choose from gallery', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: lightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Icon(Icons.arrow_back_ios, color: lightColor),
              ),
              Text(
                'Back',
                style: TextStyle(color: lightColor),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 58,
                    backgroundImage: (data['profile_image'] != null &&
                            !kIsWeb &&
                            File(data['profile_image']).existsSync())
                        ? FileImage(File(data['profile_image']))
                        : const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 2),
                  TextButton.icon(
                    icon: const Icon(Icons.border_color, color: lightColor),
                    label: const Text(
                      'Edit Photo',
                      style: TextStyle(color: lightColor),
                    ),
                    onPressed: _showImagePickerOptions,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 320,
              child: _buildTextField(
                label: 'Username',
                initialValue: data['username'] ?? '',
                onChanged: (value) => data['username'] = value,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 320,
              child: _buildTextField(
                label: 'Email',
                initialValue: data['email'] ?? '',
                onChanged: (value) => data['email'] = value,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 320,
              child: _buildTextField(
                label: 'Phone Number',
                initialValue: data['nomor_telepon'] ?? '',
                onChanged: (value) => data['nomor_telepon'] = value,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: lightColor,
                padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowProfile(data: data),
                  ),
                );
              },
              child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    final controller = TextEditingController(text: initialValue);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: lightColor),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      controller: controller,
    );
  }
}
