import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/studio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/setting/client.dart';

class Studioclient {
  static final String url = constantURL;
  static final String endpoint = '/api/studio';

  Future<Map<String, dynamic>> fetchById(int id) async {
    try {
      final response = await http.get(Uri.parse(url + endpoint + '/${id}'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load studio data');
      }
    } catch (error) {
      throw Exception('Failed to load studio data');
    }
  }

}
