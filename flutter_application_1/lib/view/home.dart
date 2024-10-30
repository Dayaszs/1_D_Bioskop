import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/listFilm.dart';

class HomeView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const HomeView({super.key, required this.userData});

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
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const FilmListView(userData: {},)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowProfile(data: widget.userData),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: lightColor,
          title: Text(
            'Atma Teater',
            style: textStyle6,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                      hintText: "Search Film Here",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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
              // Display popular films with horizontal scroll
              SizedBox(
                height: 230, // Adjusted height for card and text
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < films.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(films[i].picture),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  films[i].judul,
                                  style: textStyle2,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
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
