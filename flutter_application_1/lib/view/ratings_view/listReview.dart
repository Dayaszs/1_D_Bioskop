import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/utilities/constant.dart';

class RatingsAndReviewsView extends StatefulWidget {
  final Film film;

  const RatingsAndReviewsView({super.key, required this.film});

  @override
  _RatingsAndReviewsViewState createState() => _RatingsAndReviewsViewState();
}

class _RatingsAndReviewsViewState extends State<RatingsAndReviewsView> {
  final TextEditingController _reviewController = TextEditingController();
  double _userRating = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize the user rating with the current rating if available
    _userRating = 0.0;
  }

  // Function to create the star widgets based on rating
  List<Widget> _buildStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      Icon icon;
      if (rating >= i + 1) {
        icon = Icon(Icons.star, color: lightColor, size: 30);
      } else if (rating > i && rating < i + 1) {
        icon = Icon(Icons.star_half, color: lightColor, size: 30);
      } else {
        icon = Icon(Icons.star_border, color: lightColor, size: 30);
      }

      // Make the star icon interactive using GestureDetector
      stars.add(GestureDetector(
        onTap: () {
          setState(() {
            _userRating = i + 1.0; // Update the rating on tap
          });
        },
        child: icon,
      ));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final String username = "Kevin Tanamas";
    final String userProfileImage = "https://www.example.com/profile.jpg";
    final double userRating = 4.5;

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
                      '${widget.film.judul}',
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
                      children: _buildStarRating(_userRating),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${_userRating.toStringAsFixed(1)} / 5.0",
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
                                    widget.film.review ?? "No review yet.",
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
