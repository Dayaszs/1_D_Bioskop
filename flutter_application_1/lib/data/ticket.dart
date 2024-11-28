import 'package:flutter_application_1/data/film.dart';

class Ticket {
  final String picture;
  final String judul;
  final String genre;
  final String status;  // "Completed" or "Not Watched"

  Ticket({
    required this.picture,
    required this.judul,
    required this.genre,
    required this.status,
  });
}

final List<Ticket> tickets = films.map((film) {
  return Ticket(
    picture: film.picture,
    judul: film.judul,
    genre: film.genre,
    status: 'Not Watched',  // Assuming initially all films are "Not Watched"
  );
}).toList();
