import 'package:flutter_application_1/data/transaksi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/setting/client.dart';

class Transaksiclient {
  static final String url = constantURL;
  static final String endPoint = '/api/transaksis';

  Future<List<Transaksi>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(protocol + url + endPoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Transaksi> transaksis = data
            .map((jsonTransaksi) => Transaksi.fromJson(jsonTransaksi))
            .toList();
        return transaksis;
      } else {
        throw Exception('Failed to load transaksis');
      }
    } catch (error) {
      throw Exception('Failed to load transaksis: ${error}');
    }
  }

  Future<Map<String, dynamic>> fetchById(id) async {
    try {
      final response = await http.get(Uri.parse(protocol + url + endPoint + '/${id}'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load transaksis');
      }
    } catch (error) {
      throw Exception('Failed to load transaksis: ${error}');
    }
  }
  
}
