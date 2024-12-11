import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/bioskop.dart';

class BioskopClient {
  final String baseUrl;

  BioskopClient(this.baseUrl);

  Future<List<Bioskop>> fetchBioskops() async {
    final response = await http.get(Uri.parse('$baseUrl/bioskops'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Bioskop.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch bioskops');
    }
  }

  Future<void> updateBioskopLocation(int id, String location) async {
    final response = await http.put(
      Uri.parse('$baseUrl/bioskops/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'alamat': location}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update bioskop location');
    }
  }
}
