import 'dart:io';

import 'package:flutter_application_1/data/film.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class FilmClient {
  static final String url = 'http://10.0.2.2:8000'; // Ensure this is correct
  static final String endpoint = '/api/films';

  Future<List<Film>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(url + endpoint));

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body)['data'];
        return list.map((e) => Film.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load films. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching films: $error');
      throw Exception('Failed to load films: $error');
    }
  }
}