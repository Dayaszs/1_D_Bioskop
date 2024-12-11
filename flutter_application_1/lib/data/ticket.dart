import 'package:flutter_application_1/data/film.dart';
import 'package:flutter_application_1/data/penayangan.dart';
import 'dart:convert';

class Ticket {
  int? idTiket;
  int? idUser;
  int? idPenayangan;
  String? nomorKursi;
  Penayangan? penayangan;
  Film? film;

  Ticket({this.idTiket, this.idUser, this.idPenayangan, this.nomorKursi, this.penayangan, this.film});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      idTiket: json['id_tiket'],
      idUser: json['id_user'],
      idPenayangan: json['id_penayangan'],
      nomorKursi: json['nomor_kursi'],
      penayangan: Penayangan.fromJson(json['penayangan']),
      film: Film.fromJson(json['penayangan']['film']), 
    );
  }
}

