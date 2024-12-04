import 'dart:convert';
import 'package:flutter/rendering.dart';

class Bioskop {
  int? id_bioskop;
  String? nama;
  String? lokasi;

  Bioskop({this.id_bioskop, this.nama, this.lokasi});

  factory Bioskop.fromRawJson(String str) => Bioskop.fromJson(json.decode(str));
  factory Bioskop.fromJson(Map<String, dynamic> json) => Bioskop(
      id_bioskop: json["id_bioskop"],
      nama: json["nama"],
      lokasi: json["lokasi"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id_bioskop": id_bioskop,
    "nama": nama,
    "lokasi": lokasi
  };
}

final List<Bioskop> bioskop = _bioskop
    .map((e) => Bioskop(
        id_bioskop: e['id_bioskop'] as int,
        nama: e['nama'] as String,
        lokasi: e['lokasi'] as String))
    .toList(growable: false);

final List<Map<String, Object>> _bioskop = [
  {
    'id_bioskop': 1,
    'nama': 'Atma Cinema Amplaz',
    'lokasi': 'Kab Sleman',
  }
];
