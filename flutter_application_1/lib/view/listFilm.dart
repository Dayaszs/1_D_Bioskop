import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/profile.dart';

class FilmListView extends StatefulWidget {
  final Map<String, dynamic> userData;
  const FilmListView({super.key, required this.userData});

  @override
  State<FilmListView> createState() => _FilmListViewState();
}

class _FilmListViewState extends State<FilmListView> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(userData: widget.userData),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowProfile(data: {},),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Film", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
      ),
      body: Container(
        color: const Color.fromARGB(255, 22, 22, 22),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Pengecekan ukuran layout
            if (constraints.maxWidth > 600) {
              return const WideLayout();
            } else {
              return const NarrowLayout();
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: lightColor,
        unselectedItemColor: Colors.white, 
        onTap: _onItemTapped,
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return FilmList(
      onFilmTap: (film) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Film Detail", style: TextStyle(color: Colors.black)), 
              backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
            ),
            body: FilmDetail(film),
          ),
        ),
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Film? _film;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FilmList(
              onFilmTap: (film) => setState(() => _film = film),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _film == null 
              ? Center(
                  child: Image.asset('images/logo1.png',
                      width: 500, height: 500),
                ) 
              : FilmDetail(_film!),
        ),
      ],
    );
  }
}

class FilmList extends StatelessWidget {
  final void Function(Film) onFilmTap;

  const FilmList({super.key, required this.onFilmTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0, // Spasi vertikal antara item
        crossAxisSpacing: 10.0, // Spasi horizontal antara item
        childAspectRatio: 0.7, // Rasio aspek untuk ukuran item
      ),
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films[index];
        return GestureDetector(
          onTap: () => onFilmTap(film),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    film.picture,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  film.judul,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: lightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  film.genre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class FilmDetail extends StatelessWidget {
  final Film film;

  const FilmDetail(this.film, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, boxConstraints) {
        return Container(
          color: const Color.fromARGB(255, 22, 22, 22),
          child: Center(
            child: boxConstraints.maxHeight > 200
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(film.picture, width: 200, height: 300),
                      const SizedBox(height: 10),
                      Text(
                        film.judul,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Ubah warna teks menjadi putih
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Genre: ${film.genre}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Cast: ${film.aktor}",
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tanggal Rilis: ${film.tahun_rilis}",
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        film.deskripsi,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Book Now!"),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(film.picture, width: 100, height: 150),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              film.judul,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Genre: ${film.genre}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Cast: ${film.aktor}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tanggal Rilis: ${film.tahun_rilis}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              film.deskripsi,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Book Now!"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
