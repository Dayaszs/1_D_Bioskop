import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/utilities/constant.dart';

class RatingsAndReviewsView extends StatelessWidget {
  final Film film;

  const RatingsAndReviewsView({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _reviewController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ratings & Reviews"),
        backgroundColor: darkColor,
      ),
      body: SingleChildScrollView(
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
              
              // Film rating (stars)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < (film.ratings ?? 0).ceil()
                        ? Icons.star
                        : Icons.star_border,
                    color: lightColor,
                    size: 30,
                  ),
                ),
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
              film.review != null
                  ? Card(
                      color: const Color(0xFF222222),
                      child: ListTile(
                        title: Text(
                          film.review!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const Text(
                      "No reviews yet.",
                      style: TextStyle(color: Colors.grey),
                    ),
              const SizedBox(height: 16),
              ElevatedButton(
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
                ),
                child: const Text("Publish"),
              ),
              const SizedBox(height: 24), // Adds space between reviews
            ],
          ),
        ),
      ),
      backgroundColor: darkColor,
    );
  }
}