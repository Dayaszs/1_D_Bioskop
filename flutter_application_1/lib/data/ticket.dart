import 'package:flutter_application_1/data/film.dart';

class Ticket {
  final int id;
  final String picture;
  final String judul;
  final String genre;
  final String status;  // "Completed" or "Not Watched"

  Ticket({
    required this.id,
    required this.picture,
    required this.judul,
    required this.genre,
    required this.status,
  });
}

final List<Ticket> tickets = films.asMap().map((index, film) {
  return MapEntry(
    index,
    Ticket(
      id: 1,
      picture: film.picture,
      judul: film.judul,
      genre: film.genre,
      status: index.isEven ? 'Completed' : 'Not Watched',  // Set status based on even/odd index
    ),
  );
}).values.toList();
