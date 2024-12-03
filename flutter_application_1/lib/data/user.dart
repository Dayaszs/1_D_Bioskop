import 'dart:convert';

class User {
  final int id_user;
  final String username;
  final String password;
  final String email;
  final String nomor_telepon;
  final String tanggal_lahir;
  final String foto_profil;

  User(
      {required this.id_user,
      required this.username,
      required this.password,
      required this.email,
      required this.nomor_telepon,
      required this.foto_profil,
      required this.tanggal_lahir});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
      id_user: json["id"],
      username: json["username"],
      password: json["password"],
      email: json["email"],
      nomor_telepon: json["nomor_telepon"],
      tanggal_lahir: json["tanggal_lahir"],
      foto_profil: json["profile_picture"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id_user,
        "username": username,
        "password": password,
        "email": email,
        "nomor_telepon": nomor_telepon,
        "tanggal_lahir": tanggal_lahir,
        "foto_profil": foto_profil,
      };
}

// final List<User> users = _users
//     .map((e) => User(
//         e['id_user'] as String,
//         e['username'] as String,
//         e['password'] as String,
//         e['email'] as String,
//         e['nomor_telepon'] as String))
//     .toList(growable: false);

// final List<Map<String, Object>> _users = [{}];
