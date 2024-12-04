import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/bioskop.dart';

class Bioskopclient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/bioskop';

  Future<List<Bioskop>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(url + endpoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Bioskop> bioskops = data.map((jsonBioskop) => Bioskop.fromJson(jsonBioskop)).toList();
        return bioskops;
      } else {
        throw Exception('Failed to load bioskops');
      }
    } catch (error) {
      throw Exception('Failed to load bioskops: $error');
    }
  }
}

