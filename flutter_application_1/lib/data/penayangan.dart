import 'dart:convert';

class Penayangan {
  int? id_penayangan;
  int? id_film;
  int? id_sesi;
  int? id_studio;
  String? nomor_kursi_terpakai;
  dynamic? harga_tiket;
  String? status;
  DateTime? tanggal_tayang;

  Penayangan(
      {this.id_penayangan,
      this.id_film,
      this.id_sesi,
      this.id_studio,
      this.nomor_kursi_terpakai,
      this.harga_tiket,
      this.status,
      this.tanggal_tayang});

  factory Penayangan.fromRawJson(String str) =>
      Penayangan.fromJson(json.decode(str));
  factory Penayangan.fromJson(Map<String, dynamic> json) => Penayangan(
        id_penayangan: json["id_penayangan"],
        id_film: json["id_film"],
        id_sesi: json["id_sesi"],
        id_studio: json["id_studio"],
        nomor_kursi_terpakai: json["nomor_kursi_terpakai"],
        harga_tiket: json["harga_tiket"],
        status: json["status"],
        tanggal_tayang: DateTime.parse(json["tanggal_tayang"]),
      );

  factory Penayangan.fromJsonReview(Map<String, dynamic> json) => Penayangan(
        id_penayangan: json["id_penayangan"],
        id_film: json["id_film"],
        status: json["status"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_penayangan": id_penayangan,
        "id_film": id_film,
        "id_sesi": id_sesi,
        "id_studio": id_studio,
        "nomor_kursi_terpakai": nomor_kursi_terpakai,
        "harga_tiket": harga_tiket,
        "status": status,
        "tanggal_tayang": tanggal_tayang
      };
}
