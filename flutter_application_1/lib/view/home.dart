import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
<<<<<<< Updated upstream
=======
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/listFilm.dart';
import 'package:flutter_application_1/data/film.dart';
>>>>>>> Stashed changes

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
<<<<<<< Updated upstream
=======
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
          MaterialPageRoute(builder: (context) => FilmListView()), // Replace with actual list view
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

>>>>>>> Stashed changes
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
          child: Column(
            
          ),
        ),
      ),
    );
  }
}