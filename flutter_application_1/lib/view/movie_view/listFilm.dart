import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/movie_view/selectSeat.dart';
import 'package:flutter_application_1/view/movie_view/selectCinema.dart';
import 'package:flutter_application_1/view/ratings_view/listReview.dart';
import 'package:url_launcher/url_launcher.dart';

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
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Film Detail",
                  style: TextStyle(color: whiteColor)),
              backgroundColor: darkColor,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
  final List<Film> films;

  const WideLayout({super.key, required this.films});

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
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FilmList(films: widget.films, onFilmTap: _onFilmSelected),
          ),
        ),
        Expanded(
          flex: 2,
          child: _selectedFilm == null
              ? Center(
                  child:
                      Image.asset('images/logo1.png', width: 500, height: 500))
              : FilmDetail(_selectedFilm!),
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

class FilmDetail extends StatelessWidget {
  final Film film;

  const FilmDetail(this.film, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.45;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 16.0,
        ),
        color: const Color(0xFF161616),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero image section
            Hero(
              tag: film.judul!,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
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
                  borderRadius: BorderRadius.circular(0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        film.horizontal_picture!,
                        fit: BoxFit.cover,
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Semi-transparent button in the bottom-right corner
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () async {
                            // Check if trailer link exists and is valid
                            if (film.trailer != null &&
                                film.trailer!.isNotEmpty) {
                              final Uri url = Uri.parse(film.trailer!);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                print("Cannot launch trailer URL");
                              }
                            } else {
                              print("No trailer available for this film");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Watch Trailer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title with gradient
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.yellow.shade600, Colors.orange.shade400],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Text(
                film.judul!,
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    film.deskripsi!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Film details card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  _buildFilmDetail(
                    context,
                    "Genre",
                    film.genre!,
                    Icons.movie_filter,
                  ),
                  _buildDivider(),
                  _buildFilmDetail(
                    context,
                    "Cast",
                    film.aktor!,
                    Icons.person,
                  ),
                  _buildDivider(),
                  _buildFilmDetail(
                    context,
                    "Release Date",
                    film.tahun_rilis!,
                    Icons.calendar_today,
                  ),
                  _buildDivider(),
                  _buildFilmDetail(
                    context,
                    "Director",
                    film.sutradara!,
                    Icons.camera,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Container Review dan Ratings
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RatingsAndReviewsView(film: film),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ratings & Reviews",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        double rating = film.ratings ?? 0.0;
                        if (rating >= index + 1) {
                          return const Icon(Icons.star, color: Colors.amber, size: 30);
                        } else if (rating > index && rating < index + 1) {
                          return const Icon(Icons.star_half, color: Colors.amber, size: 30);
                        } else {
                          return const Icon(Icons.star_border, color: Colors.amber, size: 30);
                        }
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${film.ratings?.toStringAsFixed(1) ?? "0.0"} / 5',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '"${film.review ?? "No reviews available."}"',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Book Now button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFCC434),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 8,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SelectCinema()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_activity, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      "Book Now!",
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFilmDetail(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: Colors.white24, height: 1),
    );
  }
}
