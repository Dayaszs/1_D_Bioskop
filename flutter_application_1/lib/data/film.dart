import 'dart:convert';
import 'package:flutter/rendering.dart';

class Film {
  int? id_film;
  String? judul;
  String? genre;
  int? tahun_rilis;
  String? sutradara;
  String? aktor;
  String? deskripsi;
  String? poster_1;
  String? poster_2;
  String? trailer;
  String? status;
  dynamic rating;

  Film(
      {this.id_film,
      this.judul,
      this.genre,
      this.tahun_rilis,
      this.sutradara,
      this.aktor,
      this.deskripsi,
      this.poster_1,
      this.poster_2,
      this.rating,
      this.trailer,
      this.status});

  factory Film.fromRawJson(String str) => Film.fromJson(json.decode(str));
  factory Film.fromJson(Map<String, dynamic> json) => Film(
      id_film: json["id_film"],
      judul: json["judul"],
      genre: json["genre"],
      tahun_rilis: json["tahun_rilis"],
      sutradara: json["sutradara"],
      aktor: json["aktor"],
      deskripsi: json["deskripsi"],
      poster_1: json["poster_1"],
      poster_2: json["poster_2"],
      rating: json["rating"],
      trailer: json["trailer"],
      status: json["status"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_film": id_film,
        "judul": judul,
        "genre": genre,
        "tahun_rilis": tahun_rilis,
        "sutradara": sutradara,
        "aktor": aktor,
        "deskripsi": deskripsi,
        "poster_1": poster_1,
        "poster_2": poster_2,
        "rating": rating,
        "trailer": trailer,
        "status": status,
      };
}