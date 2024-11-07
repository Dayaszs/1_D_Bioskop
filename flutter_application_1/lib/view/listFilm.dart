import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/selectSeat.dart';

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
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: Colors.black,
        ),
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(child: _buildFilmLayout()),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
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
    );
  }

  Widget _buildFilterButton(String label) {
    bool isSelected = _filter == label;

    return MouseRegion(
      onEnter: (_) => setState(() => isSelected = true),
      onExit: (_) => setState(() => isSelected = false),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFCC434) : Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () => setState(() => _filter = label),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            backgroundColor: isSelected ? const Color(0xFFFCC434) : Colors.black.withOpacity(0.5),
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

  Widget _buildFilmLayout() {
    return Container(
      color: const Color.fromARGB(255, 22, 22, 22),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 600 ? const WideLayout() : const NarrowLayout();
        },
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
              title: const Text("Film Detail", style: TextStyle(color: darkColor)),
              backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: FilmDetail(film),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Film? _selectedFilm;

  void _onFilmSelected(Film film) {
    setState(() => _selectedFilm = film);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FilmList(onFilmTap: _onFilmSelected),
          ),
        ),
        Expanded(
          flex: 3,
          child: _selectedFilm == null
              ? Center(child: Image.asset('images/logo1.png', width: 500, height: 500))
              : FilmDetail(_selectedFilm!),
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
        childAspectRatio: 0.6,
      ),
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films[index];
        return GestureDetector(
          onTap: () => onFilmTap(film),
          child: _buildFilmItem(film),
        );
      },
    );
  }

  Widget _buildFilmItem(Film film) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              film.picture,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
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
    );
  }
}

class FilmDetail extends StatelessWidget {
  final Film film;

  const FilmDetail(this.film, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFF161616),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar film dengan efek bayangan dan border
            Container(
              height: 390,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.network(
                    film.picture,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Teks judul dengan gradient
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.yellow.shade600, Colors.orange.shade400],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Text(
                film.judul,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            // Detail film dengan ikon
            _buildFilmDetail("Genre", film.genre),
            _buildFilmDetail("Cast", film.aktor),
            _buildFilmDetail("Release Date", film.tahun_rilis),
            const SizedBox(height: 20),
            // Deskripsi film
            Text(
              film.deskripsi,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            // Tombol Book Now
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFCC434),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectSeat()),
                );
              },
              child: const Text(
                "Book Now!",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilmDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
