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
    _userRating = 0.0; // Default rating
  }

  // Function to create the star widgets based on rating
  List<Widget> _buildStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      Icon icon;
      if (rating >= i + 1) {
        icon = Icon(Icons.star, color: lightColor, size: 40);
      } else if (rating > i && rating < i + 1) {
        icon = Icon(Icons.star_half, color: lightColor, size: 40);
      } else {
        icon = Icon(Icons.star_border, color: lightColor, size: 40);
      }

      // Adding animation to stars
      stars.add(GestureDetector(
        onTap: () {
          setState(() {
            _userRating = i + 1.0;
          });
        },
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 300),
          child: icon,
        ),
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
        elevation: 0, // Menghilangkan bayangan pada AppBar
        toolbarHeight: 80, // Menyesuaikan tinggi app bar jika diperlukan
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
                        fontSize: 26,
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

                    // Review input with border animation effect
                    TextField(
                      controller: _reviewController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Add a review",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.white24,
                      height: 32,
                    ),

                    // All Reviews section
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

                    Card(
                      elevation: 0, // Menghilangkan bayangan pada Card
                      margin: const EdgeInsets.only(bottom: 16),
                      color: Colors.transparent, // Pastikan latar belakang Card transparan
                      child: Container(
                        color: Colors.transparent, // Pastikan latar belakang Container transparan
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(userProfileImage),
                              radius: 25,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Publish Review Button with hover effect
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
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
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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