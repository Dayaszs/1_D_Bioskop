import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/review.dart';

class ReviewClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/reviews';

  Future<List<Review>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(url + endpoint));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Review> reviews =
            data.map((jsonReview) => Review.fromJson(jsonReview)).toList();
        return reviews;
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (error) {
      throw Exception('Failed to load reviews: $error');
    }
  }
}
