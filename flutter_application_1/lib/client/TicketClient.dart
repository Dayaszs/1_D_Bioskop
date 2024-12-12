import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/ticket.dart';
import 'package:flutter_application_1/setting/client.dart';

class TicketClient {
  static final String url = constantURL;
  static final String endpoint = '/api/tikets';

  Future<List<Ticket>> fetchOnlyUsers(id_user) async {
    try {
      final response =
          await http.get(Uri.parse(protocol + url + endpoint + '/${id_user}'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((ticketJson) => Ticket.fromJson(ticketJson)).toList();
      } else {
        throw Exception('Failed to load tickets');
      }
    } catch (e) {
      throw Exception('Error fetching tickets: $e');
    }
  }

  // Fungsi untuk mengambil tiket berdasarkan userId
  Future<int?> fetchUserTicket(int id_user) async {
    try {
      final response = await http.get(Uri.parse('$url$endpoint/$id_user'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['id_tiket']; // Ambil ID tiket dari API
      } else {
        throw Exception("Failed to fetch ticket");
      }
    } catch (e) {
      throw Exception("Error fetching ticket: $e");
    }
  }
}
