import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/movie_view/filmDetail.dart';

class FilmListView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FilmListView({super.key, required this.userData});

  @override
  State<FilmListView> createState() => _FilmListViewState();
}

class _FilmListViewState extends State<FilmListView> {
  String _filter = 'Now Playing';

  List<Film> get _filteredFilms {
    return _filter == 'Now Playing' ? films : comingSoonFilms;
  }

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
    return Container(
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
    );
  }

  Widget _buildFilmLayout() {
    return Container(
      color: const Color.fromARGB(255, 22, 22, 22),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 600
              ? WideLayout(films: _filteredFilms)
              : NarrowLayout(films: _filteredFilms);
        },
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final List<Film> films;

  const NarrowLayout({super.key, required this.films});

  @override
  Widget build(BuildContext context) {
    return FilmList(
      films: films,
      onFilmTap: (film) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FilmDetail(film: film),
        ),
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  final List<Film> films;

  const WideLayout({super.key, required this.films});

  @override
  State<WideLayout> createState() => _WideLayoutState();
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
        Flexible(
          flex: 1,
          child: FilmList(films: widget.films, onFilmTap: _onFilmSelected),
        ),
        Expanded(
          flex: 2,
          child: _selectedFilm == null
              ? Center(
                  child:
                      Image.asset('images/logo1.png', width: 500, height: 500))
              : FilmDetail(film: _selectedFilm!),
        ),
      ],
    );
  }
}

class FilmList extends StatelessWidget {
  final List<Film> films;
  final void Function(Film) onFilmTap;

  const FilmList({super.key, required this.films, required this.onFilmTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
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
              film.picture!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            film.judul!,
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
            film.genre!,
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
