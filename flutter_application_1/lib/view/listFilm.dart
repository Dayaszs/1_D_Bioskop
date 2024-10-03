import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';

class FilmListView extends StatefulWidget {
  const FilmListView({super.key});

  @override
  State<FilmListView> createState() => ListNamaView();
}

class ListNamaView extends State<FilmListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Film"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Pengecekan ukuran layout
          if (constraints.maxWidth > 600) {
            return const WideLayout();
          } else {
            return const NarrowLayout();
          }
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
            appBar: AppBar(),
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
          child: _film == null ? const Placeholder() : FilmDetail(_film!),
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
    return ListView(
      children: [
        for (var film in films)
          ListTile(
            leading: Image.network(film.picture),
            title: Text(film.judul),
            onTap: () => onFilmTap(film),
          ),
      ],
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
        return Center(
          child: boxConstraints.maxHeight > 200
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      onHover: (_) => {print("Hello World")},
                      child: Text(film.judul),
                    ),
                    Text(film.genre),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Book Now!"),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MouseRegion(
                      onHover: (_) => {print("Hello World")},
                      child: Text(film.judul),
                    ),
                    Text(film.deskripsi),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Book Now!"),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
