import 'dart:convert';

class Review {
  final int id_review;
  final int id_tiket;
  final int rating;
  final String komentar;

  Review({
    required this.id_review,
    required this.id_tiket,
    required this.rating,
    required this.komentar,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id_review: json["id_review"],
      id_tiket: json["id_tiket"],
      rating: json["rating"],
      komentar: json["komentar"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id_review" : id_review,
    "id_tiket" : id_tiket,
    "rating" : rating,
    "komentar" : komentar,
  };
}
