import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/fnb.dart';

class Menuclient {
  static final String url = 'http://10.0.2.2:8000'; // Ensure this is correct
  static final String endpoint = '/api/menus';


  Future<List<Fnb>> fetchMenus() async {
      final response = await http.get(Uri.parse(url + endpoint));

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return list.map((e) => Fnb.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load menus');
      }
}}