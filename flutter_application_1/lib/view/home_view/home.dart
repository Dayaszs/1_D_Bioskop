import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/home_view/listFnB.dart';
import 'package:flutter_application_1/view/ticket_view/ticketView.dart';
import 'package:flutter_application_1/view/profile_view/profile.dart';
import 'package:flutter_application_1/view/movie_view/listFilm.dart';
import 'package:flutter_application_1/view/home_view/location.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_application_1/client/FilmClient.dart';
import 'package:flutter_application_1/client/MenuClient.dart';
import 'package:flutter_application_1/data/fnb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/utilities/constant.dart';

// Provider to fetch films
final listFilmProvider = FutureProvider<List<Film>>((ref) async {
  return await FilmClient().fetchAll();
});
final listMenuProvider = FutureProvider<List<Fnb>>((ref) async {
  return await Menuclient().fetchMenus();
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
  double currentPage = 0;
  late Future<List<Fnb>> _fnbs;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _fnbs = Menuclient().fetchMenus();
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
    final menusAsync = ref.watch(listMenuProvider);

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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, left: 4.0, bottom: 18.0),
                          child: Text(
                            "Now Playing",
                            style: textStyle2.copyWith(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, right: 4.0, bottom: 18.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FilmListView(userData: widget.userData),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              children: [
                                Text("More", style: TextStyle(color: lightColor)),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios,
                                    color: lightColor, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 380,
                      child: CarouselSlider.builder(
                        itemCount: films.length,
                        options: CarouselOptions(
                          height: 450,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.5,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPage = index.toDouble();
                            });
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final film = films[index % films.length];
                          return GestureDetector(
                            onTap: () {
                              // Aksi ketika film ditekan
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 200,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(film.poster_1!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 170,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        film.judul!,
                                        style: textStyle2.copyWith(fontSize: 18),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${film.tahun_rilis} • ${film.genre}",
                                        style: textStyle2.copyWith(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.yellow, size: 16),
                                          Text(
                                            film.rating.toString(),
                                            style: textStyle2.copyWith(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, left: 4.0, bottom: 18.0),
                          child: Text(
                            "Food and Beverage",
                            style: textStyle2.copyWith(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, right: 4.0, bottom: 18.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ListFnbView(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              children: [
                                Text("More", style: TextStyle(color: lightColor)),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios,
                                    color: lightColor, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    menusAsync.when(
                      data: (menu) {
                        return SizedBox(
                          height: 160,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var i = 0; i < menu.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(menu[i].gambar!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          menu[i].nama!,
                                          style: textStyle2.copyWith(fontSize: 14),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(child: Text('Failed to load data')),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
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
