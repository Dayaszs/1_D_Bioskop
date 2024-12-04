import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/view/movie_view/selectCinema.dart';
import 'package:flutter_application_1/view/ratings_view/listReview.dart';
import 'package:url_launcher/url_launcher.dart';

class FilmDetail extends StatelessWidget {
  final Film film;

  const FilmDetail({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Film Detail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: darkColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF161616),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Image Section
              Stack(
                children: [
                  Image.network(
                    film.horizontal_picture!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: size.height * 0.3,
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (film.trailer != null && film.trailer!.isNotEmpty) {
                          final Uri url = Uri.parse(film.trailer!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Cannot launch trailer URL"),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: const Text(
                        "Watch Trailer",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title Section
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.yellow.shade600, Colors.orange.shade400],
                  ).createShader(bounds);
                },
                child: Center(
                  child: Text(
                    film.judul!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Synopsis Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Synopsis",
                        style: TextStyle(
                          fontSize: 20,
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
              ),
              const SizedBox(height: 16),

              // Film Details Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow("Genre", film.genre!, Icons.movie_filter),
                      _buildDivider(),
                      _buildDetailRow("Cast", film.aktor!, Icons.person),
                      _buildDivider(),
                      _buildDetailRow("Release Date", film.tahun_rilis!,
                          Icons.calendar_today),
                      _buildDivider(),
                      _buildDetailRow(
                          "Director", film.sutradara!, Icons.camera),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ratings and Reviews Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildRatingsAndReviews(context),
              ),

              const SizedBox(height: 24),

              // Book Now Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildBookNowButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 24),
        const SizedBox(width: 12),
        Text(
          "$label:",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: Colors.white24, height: 1),
    );
  }

  Widget _buildRatingsAndReviews(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RatingsAndReviewsView(film: film),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Ratings & Reviews",
              style: TextStyle(
                fontSize: 20,
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
                  return const Icon(Icons.star_half,
                      color: Colors.amber, size: 30);
                } else {
                  return const Icon(Icons.star_border,
                      color: Colors.amber, size: 30);
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
          ],
        ),
      ),
    );
  }

  Widget _buildBookNowButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SelectCinema()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFCC434),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.local_activity, size: 24),
          SizedBox(width: 8),
          Text(
            "Book Now",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
