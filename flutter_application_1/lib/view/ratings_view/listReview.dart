import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/utilities/constant.dart';

class RatingsAndReviewsView extends StatelessWidget {
  final Film film;

  const RatingsAndReviewsView({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _reviewController = TextEditingController();

    final String username = "Kevin Tanamas";
    final String userProfileImage = "https://www.example.com/profile.jpg";
    final double userRating = 4.5;

    // Function to create the star widgets based on rating
    List<Widget> _buildStarRating(double rating) {
      List<Widget> stars = [];
      for (int i = 0; i < 5; i++) {
        if (rating >= i + 1) {
          stars.add(Icon(Icons.star, color: lightColor, size: 30));
        } else if (rating > i && rating < i + 1) {
          stars.add(Icon(Icons.star_half, color: lightColor, size: 30));
        } else {
          stars.add(Icon(Icons.star_border, color: lightColor, size: 30));
        }
      }
      return stars;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ratings & Reviews"),
        backgroundColor: darkColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Film title
                    Text(
                      film.judul,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Film rating (stars) - dynamic stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildStarRating(film.ratings ?? 0),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${film.ratings?.toStringAsFixed(1) ?? "0.0"} / 5.0",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 24),

                    // Review input
                    TextField(
                      controller: _reviewController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Add a review",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.white24,
                      height: 32,
                    ),
                    // Reviews list
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "All Reviews",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Wrapper for User Profile & Review
                    Card(
                      color: const Color(0xFF222222),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align items to start
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(userProfileImage),
                              radius: 25,
                            ),
                            const SizedBox(width: 12),
                            Expanded( // Use Expanded widget to prevent overflow
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                                children: [
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: _buildStarRating(userRating),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    film.review ?? "No review yet.",
                                    style: const TextStyle(color: Colors.white),
                                    maxLines: null, // Allows the text to wrap
                                    overflow: TextOverflow.visible, // Ensures the text is not truncated
                                  ),
                                ],
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
            ),
          ),
          // Button to publish review
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement action for saving the review
                if (_reviewController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Review added successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _reviewController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightColor,
                minimumSize: Size(double.infinity, 60), // Make the button larger
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              child: const Text(
                "Publish Review",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkColor),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: darkColor,
    );
  }
}
