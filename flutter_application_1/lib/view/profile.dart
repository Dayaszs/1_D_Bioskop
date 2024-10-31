import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/listFilm.dart';
import 'package:flutter_application_1/view/login.dart'; // Import halaman login

class ShowProfile extends StatefulWidget {
  final Map<String, dynamic> data;

  const ShowProfile({super.key, required this.data});

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 2;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(userData: widget.data),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FilmListView(userData: widget.data),
          ),
        );
        break;
      case 2:
        break;
    }
  }

  void _logout() {
    // Arahkan ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()), // Ganti dengan halaman login Anda
    );
  }

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
                  backgroundImage: (widget.data['profile_image'] != null &&
                          File(widget.data['profile_image']).existsSync())
                      ? FileImage(File(widget.data['profile_image']))
                      : const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.data['username'] ?? 'John Doe',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.data['email'] ?? 'johndoe@gmail.com',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.data['nomor_telepon'] ?? '08923126788',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightColor, 
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(5)),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: darkColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movie List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: lightColor,
          unselectedItemColor: Colors.white, 
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
