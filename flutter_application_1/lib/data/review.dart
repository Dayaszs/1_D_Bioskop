import 'dart:convert';
import 'package:flutter/rendering.dart';

class Review {
  
  int? id_review;
  int? id_tiket;
  int? rating;
  String? komentar;

  Review({
    this.id_review,
    this.id_tiket,
    this.rating,
    this.komentar,
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
