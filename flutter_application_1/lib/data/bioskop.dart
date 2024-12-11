class Bioskop {
  final int idBioskop;
  final String namaBioskop;
  final String alamat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Bioskop({
    required this.idBioskop,
    required this.namaBioskop,
    required this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  factory Bioskop.fromJson(Map<String, dynamic> json) {
    return Bioskop(
      idBioskop: json['id_bioskop'],
      namaBioskop: json['nama_bioskop'],
      alamat: json['alamat'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

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
