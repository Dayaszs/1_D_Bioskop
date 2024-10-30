class User {
  final String id_user;
  final String username;
  final String password;
  final String email;
  final String nomor_telepon;
  const User(this.id_user, this.username, this.password, this.email,
      this.nomor_telepon);
}

final List<User> users =
    _users.map((e) => User(
      e['id_user'] as String, 
      e['username'] as String,
      e['password'] as String,
      e['email'] as String,
      e['nomor_telepon'] as String))
      .toList(growable: false);

final List<Map<String, Object>> _users = [{}];

