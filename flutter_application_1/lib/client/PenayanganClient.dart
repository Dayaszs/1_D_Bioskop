import 'package:flutter_application_1/data/penayangan.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/setting/client.dart';

class PenayanganClient {
  static final String url = constantURL;
  static final String endpoint = '/api/searchPenayangan';

  Future<Map<String, dynamic>> fetchPenayangan({
    required int id_film,
    required int id_sesi,
    required String tanggal_tayang,
    required int id_studio,
  }) async {
    try {
      final response = await http.post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'id_film': id_film,
          'id_sesi': id_sesi,
          'tanggal_tayang': tanggal_tayang,
          'id_studio': id_studio
        }),
      );

      print(
          "id film : $id_film , id_sesi : $id_sesi , tanggal tayang : $tanggal_tayang , id studio : $id_studio , response ${response.body} , status code : ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load penayangan ${json.decode(response.body)}');
      }
    } catch (error) {
      throw Exception('Failed to load penayangan: $error');
    }
  }
}
