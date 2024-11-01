import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import kIsWeb untuk platform check
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/listFilm.dart';

class ShowProfile extends StatefulWidget {
  final Map<String, dynamic> data;

  const ShowProfile({super.key, required this.data});

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
                  child: CircleAvatar(
                    radius: 58,
                    backgroundImage: (widget.data['profile_image'] != null &&
                            !kIsWeb &&
                            File(widget.data['profile_image']).existsSync())
                        ? FileImage(File(widget.data['profile_image']))
                        : const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.data['username'] ?? 'John Doe',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.data['email'] ?? 'johndoe@gmail.com',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const Divider(
                  height: 40,
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                _buildProfileItem(
                  icon: Icons.phone,
                  title: 'Phone',
                  value: widget.data['nomor_telepon'] ?? '08923126788',
                ),
                const SizedBox(height: 20),
                _buildProfileItem(
                  icon: Icons.location_on,
                  title: 'Location',
                  value: widget.data['location'] ?? 'Indonesia',
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Add action for edit profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem({required IconData icon, required String title, required String value}) {
    return Row(
      children: [
        Icon(icon, color: const Color.fromRGBO(255, 193, 7, 1)),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
