import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShowProfile extends StatelessWidget {
  final Map<String, dynamic> data;

  const ShowProfile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 58,
              backgroundImage: (data['profile_image'] != null &&
                      !kIsWeb &&
                      File(data['profile_image']).existsSync())
                  ? FileImage(File(data['profile_image']))
                  : const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 16),
            Text(
              data['username'] ?? 'user1',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            buildInfoText('Phone Number :', data['nomor_telepon'] ?? 'No Phone Number'),
            const SizedBox(height: 10),
            buildInfoText('Email :', data['email'] ?? 'No Email'),
            const SizedBox(height: 30),
            buildOptionButton(context, Icons.confirmation_number, 'My ticket', () {
              // Navigate to "My Ticket" page
            }),
            buildOptionButton(context, Icons.edit, 'Edit Profile', () {
              // Navigate to "Edit Profile" page
            }),
            buildOptionButton(context, Icons.lock, 'Change password', () {
              // Navigate to "Change Password" page
            }),
            const Spacer(),
            buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildInfoText(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          info,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }

  Widget buildOptionButton(
      BuildContext context, IconData icon, String text, VoidCallback onPressed) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
      onTap: onPressed,
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/login'); // Navigate to login page
        },
        child: const Text(
          'Log Out',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }
}