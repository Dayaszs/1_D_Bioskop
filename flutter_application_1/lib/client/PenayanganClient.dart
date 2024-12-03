import 'dart:io';

import 'package:flutter_application_1/data/penayangan.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PenayanganClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/penayangans';
}