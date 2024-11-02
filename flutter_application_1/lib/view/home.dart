import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/listFilm.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const HomeView({super.key, required this.userData});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  final TextEditingController _searchController = TextEditingController();

  List<Widget> _buildScreens() {
    return [
      _buildHomeScreen(),
      const Center(child: Text("Ticket Page", style: textStyle6)),
      FilmListView(userData: widget.userData),
      ShowProfile(data: widget.userData),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: lightColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.confirmation_number),
        title: "Ticket",
        activeColorPrimary: lightColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.movie),
        title: "Movie",
        activeColorPrimary: lightColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: lightColor,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  Widget _buildHomeScreen() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: lightColor,
            ),
          ),
          title: const Text(
            'Atma Teater',
            style: textStyle6,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Film Here",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(child: Text("Featured Movie", style: textStyle2)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Now Playing", style: textStyle2),
              ),
            ),
            Expanded( // Menggunakan Expanded agar konten dapat digulir
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < films.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                        child: Column(
                          children: [
                            Container(
                              width: 140,
                              height: 210,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(films[i].picture),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 140,
                              child: Text(
                                films[i].judul,
                                style: textStyle5.copyWith(color: Colors.white),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: darkColor,
      navBarStyle: NavBarStyle.style6,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.black,
      ),
    );
  }
}
