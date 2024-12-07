import 'package:flutter_application_1/data/film.dart';
import 'dart:convert';

class Ticket {
  int? id;
  String? picture;
  String? judul;
  String? genre;
  dynamic? status; // "Completed" or "Not Watched"

  Ticket({
    this.id,
    this.picture,
    this.judul,
    this.genre,
    this.status,
  });

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));
  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        picture: json["picture"],
        judul: json["judul"],
        genre: json["genre"],
        status: json["status"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "judul": judul,
        "genre": genre,
        "status": status,
      };
}

final List<Ticket> tickets = films
    .asMap()
    .map((index, film) {
      return MapEntry(
        index,
        Ticket(
          id: 1,
          picture: film.poster_1,
          judul: film.judul,
          genre: film.genre,
          status: index.isEven
              ? 'Completed'
              : 'Not Watched', // Set status based on even/odd index
        ),
      );
    })
    .values
    .toList();
