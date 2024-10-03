import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/home.dart';

class HomeView extends StatefulWidget {
  final Map<String, dynamic> userData; // Add this to pass the user data

  const HomeView({super.key, required this.userData}); // Update constructor

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView(userData: widget.userData)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListView()), // Replace with actual list view
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowProfile(data: widget.userData), // Pass user data to ShowProfile
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: lightColor,
        ),
        body: Center(
          child: Text('Home Content'), // Replace with actual home content
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: lightColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
