import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/sesi.dart';

class Sesiclient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/sesis';

  Future<List<Sesi>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(url + endpoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Sesi> sesis = data.map((jsonSesi) => Sesi.fromJson(jsonSesi)).toList();
        return sesis;
      } else {
        throw Exception('Failed to load sesis');
      }
    } catch (error) {
      throw Exception('Failed to load sesis: $error');
    }
  }
  
}