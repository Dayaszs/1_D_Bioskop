import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;
      case 1:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ListView()), //ganti kelas list
        // );
        break;
      case 2:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ShowProfile()), //ganti kelas profile
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
        backgroundColor: lightColor, // Warna latar belakang AppBar
        title: Text(
          'Atma Teater', // Judul di AppBar
          style: textStyle6, // Styling teks judul
        ),
        centerTitle: true, // Membuat judul di tengah
        automaticallyImplyLeading: false, // Menghilangkan tombol back // Menghilangkan tombol back
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 370,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search Film Here", // Teks hint
                      prefixIcon: Icon(Icons.search), // Ikon search di sebelah kiri
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear), // Tombol untuk clear input
                        onPressed: () {
                          _searchController.clear(); // Aksi untuk clear text input
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // Radius border
                        borderSide: BorderSide.none, // Hilangkan garis border
                      ),
                      filled: true, // Background terisi warna
                      fillColor: Colors.grey[200], // Warna background search bar
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding dalam search bar
                    ),
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: lightColor,
                  ),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 12.0, bottom: 12.0),
                    child: Text("Film Populer Saat Ini : ", style: textStyle2),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 150,
                        color: lightColor,
                      ),
                      Container(
                        width: 100,
                        height: 150,
                        color: lightColor,
                      ),
                      Container(
                        width: 100,
                        height: 150,
                        color: lightColor,
                      ),
                    ],
                  ),

                ],
              )
            ],
          ),
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

