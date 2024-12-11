import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/ticket.dart';
import 'package:flutter_application_1/setting/client.dart';

class TicketClient {
  static final String url = constantURL;
  static final String endpoint = '/api/tikets';

  Future<List<Ticket>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(url + endpoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Ticket> tickets =
            data.map((jsonTicket) => Ticket.fromJson(jsonTicket)).toList();
        return tickets;
      } else {
        throw Exception('Failed to load tickets');
      }
    } catch (error) {
      throw Exception('Failed to load tickets: $error');
    }
  }

  Future<List<Ticket>> fetchOnlyUsers(id_user) async {
    try {
      final response =
          await http.get(Uri.parse(url + endpoint + '/${id_user}'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Ticket> tickets =
            data.map((jsonTicket) => Ticket.fromJson(jsonTicket)).toList();
        return tickets;
      } else {
        throw Exception("Failed to load user's tickets");
      }
    } catch (error) {
      throw Exception("Failed to load user's tickets: $error");
    }
  }
}
