import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/ticket_view/ticketView.dart';
import 'package:flutter_application_1/view/profile_view/profile.dart';
import 'package:flutter_application_1/view/movie_view/listFilm.dart';
import 'package:flutter_application_1/view/home_view/location.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_application_1/client/FilmClient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/utilities/constant.dart';

// Provider to fetch films
final listFilmProvider = FutureProvider<List<Film>>((ref) async {
  return await FilmClient().fetchAll();
});

class HomeView extends ConsumerStatefulWidget {
  final Map<String, dynamic> userData;

  const HomeView({super.key, required this.userData});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late PersistentTabController _controller;
  String location = "No location detected";

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      _buildHomeScreen(),
      TicketView(),
      FilmListView(userData: widget.userData),
      ShowProfile(data: widget.userData),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.confirmation_number),
        title: ("Ticket"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.movie),
        title: ("Movie"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  Widget _buildHomeScreen() {
    final filmsAsync = ref.watch(listFilmProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(220),
          child: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Hi, ${widget.userData['username']}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(27),
                        border: Border.all(color: Colors.black12, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: TextEditingController(),
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black54),
                          prefixIcon: Icon(Icons.search, color: Colors.black87),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationPage(),
                          ),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              location = value;
                            });
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            location,
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationPage(),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    location = value;
                                  });
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: filmsAsync.when(
          data: (films) {
            return ListView(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                  ),
                  items: films.map((film) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              film.poster_1!,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Now Playing',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
              child:
                  Text("Error: $error", style: TextStyle(color: Colors.white))),
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
      backgroundColor: Colors.black,
      navBarStyle: NavBarStyle.style6,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.black,
      ),
    );
  }
}
