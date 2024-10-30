import 'dart:io';
import 'package:flutter/material.dart';

class ShowProfile extends StatelessWidget {
  final Map<String, dynamic> data;

  const ShowProfile({super.key, required this.data});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: (data['profile_image'] != null && 
                                  File(data['profile_image']).existsSync())
                      ? FileImage(File(data['profile_image']))
                      : const AssetImage('assets/placeholder.png'),
                  // Periksa dan gunakan placeholder jika tidak ada gambar
                ),
              ),
              const SizedBox(height: 20),
              Text(
                data['username'] ?? 'Nama tidak tersedia',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data['email'] ?? 'Email tidak tersedia',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                data['nomor_telepon'] ?? 'Nomor telepon tidak tersedia',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
