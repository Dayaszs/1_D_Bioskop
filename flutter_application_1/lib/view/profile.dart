import 'dart:io'; // Tambahkan ini untuk menangani gambar file lokal
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
              // Circular profile picture with border
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: data['profile_image'] != null 
                      ? FileImage(File(data['profile_image'])) // Gambar dari file lokal
                      : AssetImage('assets/placeholder.png') as ImageProvider, // Placeholder jika tidak ada gambar
                ),
              ),
              const SizedBox(height: 20),
              // Display the name and email
              Text(
                data['username'], // Username dari registrasi
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data['email'], // Email dari registrasi
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Display phone number
              Text(
                data['nomor_telepon'], // Nomor telepon dari registrasi
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
