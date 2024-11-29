import 'package:flutter_application_1/data/user.dart';

import 'dart:convert';
import 'package:http/http.dart';

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/users';

  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, '$endpoint'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  
}
