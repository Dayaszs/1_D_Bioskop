import 'dart:convert';

class Bioskop {
  int? idBioskop;
  String? namaBioskop;
  String? alamat;
  DateTime? createdAt;
  DateTime? updatedAt;

  Bioskop({
    this.idBioskop,
    this.namaBioskop,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  factory Bioskop.fromRawJson(String str) => Bioskop.fromJson(json.decode(str));
  factory Bioskop.fromJson(Map<String, dynamic> json) {
    return Bioskop(
      idBioskop: json['id_bioskop'],
      namaBioskop: json['nama_bioskop'],
      alamat: json['alamat'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() {
    return {
      'id_bioskop': idBioskop,
      'nama_bioskop': namaBioskop,
      'alamat': alamat,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
