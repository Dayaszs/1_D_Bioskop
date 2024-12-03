import 'dart:io';

import 'package:flutter_application_1/data/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/users';

  // static Future<List<User>> fetchAll() async {
  //   try {
  //     var response = await get(Uri.http(url, '$endpoint'));

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     Iterable list = json.decode(response.body)['data'];

  //     return list.map((e) => User.fromJson(e)).toList();
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Mengirim data login
      var response = await http.post(
        Uri.http(url, '/api/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Invalid credentials');
      }

      var data = json.decode(response.body);

      String token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', data['user']['username']);
      await prefs.setString('auth_token', token);

      return {
        'user': data["user"],
        'token': data['token'],
      };
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String birthDate, // Added birthDate parameter
    required File profilePicture,
  }) async {
    try {
      var uri = Uri.http(url, '/api/register');

      var request = http.MultipartRequest('POST', uri)
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['nomor_telepon'] = phoneNumber
        ..fields['tanggal_lahir'] =
            birthDate; // Add birthDate to request fields

      // Adding profile picture if it exists
      if (profilePicture != null) {
        var pic = await http.MultipartFile.fromPath(
            'profile_picture', profilePicture.path);
        request.files.add(pic);
      }

      var response = await request.send();

      // Checking the status code of the response
      if (response.statusCode != 200) {
        var responseData = await response.stream.bytesToString();
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}, body: $responseData');
      }

      // Decode response
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);

      // Store token and user data in shared preferences
      String token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', data['user']['username']);
      await prefs.setString('auth_token', token);

      return {
        'user': data["user"],
        'token': token,
      };
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required String id,
    required String username,
    required String email,
    required String phoneNumber,
    required File profilePicture, // Profile picture is optional
  }) async {
    try {
      var uri = Uri.http(url, '/api/user/update/$id');

      var request = http.MultipartRequest('POST', uri)
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['nomor_telepon'] = phoneNumber;

      // Adding profile picture if it exists
      if (profilePicture != null) {
        var pic = await http.MultipartFile.fromPath(
          'profile_picture',
          profilePicture.path,
        );
        request.files.add(pic);
      }

      var response = await request.send();

      // Checking the status code of the response
      if (response.statusCode != 200) {
        var responseData = await response.stream.bytesToString();
        throw Exception(
            'Failed to update user. Status code: ${response.statusCode}, body: $responseData');
      }

      // Decode response
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);

      // Store updated user data and token if needed
      String token = data['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', data['user']['username']);
      await prefs.setString('auth_token', token);

      return {
        'user': data['user'],
        'token': token,
      };
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
