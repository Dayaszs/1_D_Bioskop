import 'package:flutter_application_1/data/penayangan.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/setting/client.dart';

class PenayanganClient {
  static final String url = constantURL;
  static final String endpoint = '/api/penayangans';

  Future<Map<String, dynamic>> fetchPenayangan({
    int? id_film,
    int? id_sesi,
    String? tanggal_tayang,
    int? id_studio,
  }) async {
    try {

      var response = await http.post(
        Uri.http(url, '/searchPenayangan'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'id_film': id_film,
          'id_sesi': id_sesi,
          'id_studio': id_studio,
          'tanggal_tayang': tanggal_tayang
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Penayangan tidak ditemukan');
      }
    } catch(error) {
      return Future.error(error.toString());
    }
  }
}
