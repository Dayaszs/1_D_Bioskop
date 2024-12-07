// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Film {
//   final String idFilm;
//   final String title;
//   final String genre;
//   final String releaseYear;
//   final String director;
//   final String actors;
//   final String description;
//   final String poster1;
//   final String poster2;
//   final double? rating;
//   final String? review;
//   final String trailerUrl;
//   final int duration;

//   Film({
//     required this.idFilm,
//     required this.title,
//     required this.genre,
//     required this.releaseYear,
//     required this.director,
//     required this.actors,
//     required this.description,
//     required this.poster1,
//     required this.poster2,
//     this.rating,
//     this.review,
//     required this.trailerUrl,
//     required this.duration,
//   });

//   // Factory constructor untuk membuat objek Film dari JSON
//   factory Film.fromMap(Map<String, dynamic> map) {
//     return Film(
//       idFilm: map['id_film'],
//       title: map['judul'],
//       genre: map['genre'],
//       releaseYear: map['tahun_rilis'],
//       director: map['sutradara'],
//       actors: map['aktor'],
//       description: map['deskripsi'],
//       poster1: map['poster_1'],
//       poster2: map['poster_2'],
//       rating: map['ratings']?.toDouble(),
//       review: map['review'],
//       trailerUrl: map['trailer'],
//       duration: map['durasi'],
//     );
//   }

//   // Fungsi untuk mengambil data film dari API Laravel
//   static Future<List<Film>> fetchFilms() async {
//     final response = await http.get(Uri.parse('http://localhost/api/films'));

//     if (response.statusCode == 200) {
//       // Parse data JSON yang diterima dari API
//       List<dynamic> data = json.decode(response.body);
//       return data.map((filmData) => Film.fromMap(filmData)).toList();
//     } else {
//       throw Exception('Failed to load films');
//     }
//   }
// }
