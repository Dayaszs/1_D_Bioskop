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
  String _filter = 'Now Playing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25),
        child: AppBar(
          title:
              const Text("Daftar Film", style: TextStyle(color: Colors.black)),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 22, 22, 22),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton("Now Playing"),
                const SizedBox(width: 6),
                _buildFilterButton("Coming Soon"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 22, 22, 22),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return const WideLayout();
                  } else {
                    return const NarrowLayout();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    bool isSelected = _filter == label;

    return MouseRegion(
      onEnter: (_) => setState(() => isSelected = true),
      onExit: (_) => setState(() => isSelected = false),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFCC434)
              : Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () => setState(() => _filter = label),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            backgroundColor: isSelected
                ? const Color(0xFFFCC434)
                : Colors.black.withOpacity(0.5),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white.withOpacity(0.5),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
              title: const Text("Film Detail",
                  style: TextStyle(color: Colors.black)),
              backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
            ),
            body: FilmDetail(film),
          ),
        ),
      ),
    );
  }
}

class WideLayout extends StatelessWidget {
  const WideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Film? _film;

    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FilmList(
              onFilmTap: (film) => _film = film,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _film == null
              ? Center(
                  child:
                      Image.asset('images/logo1.png', width: 500, height: 500),
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
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.7,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Corner radius
                  child: Image.network(
                    film.picture,
                    fit: BoxFit.cover,
                    width: 191, // Width
                    height: 267, // Height
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
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12), // Corner radius
                        child: Image.network(
                          film.picture,
                          width: 191, // Width
                          height: 267, // Height
                          fit: BoxFit.cover, // Maintain aspect ratio
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        film.judul,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tanggal Rilis: ${film.tahun_rilis}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        film.deskripsi,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
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
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12), // Corner radius
                        child: Image.network(
                          film.picture,
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover, // Maintain aspect ratio
                        ),
                      ),
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