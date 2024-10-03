class Film {
  final String id_film;
  final String judul;
  final String genre;
  final String tahun_rilis;
  final String sutradara;
  final String aktor;
  final String deskripsi;
  final String picture;
  const Film(this.id_film, this.judul, this.genre, this.tahun_rilis,
      this.sutradara, this.aktor, this.deskripsi, this.picture);
}

final List<Film> films =
    _films.map((e) => Film(
      e['id_film'] as String, 
      e['judul'] as String,
      e['genre'] as String,
      e['tahun_rilis'] as String,
      e['sutradara'] as String,
      e['aktor'] as String,
      e['deskripsi'] as String,
      e['picture'] as String,))
      .toList(growable: false);

final List<Map<String, Object>> _films = [
  {
    'id_film': 'F001',
    'judul': 'Inception',
    'genre': 'Sci-Fi',
    'tahun_rilis': '2010',
    'sutradara': 'Christopher Nolan',
    'aktor': 'Leonardo DiCaprio',
    'deskripsi': 'A thief who enters the dreams of others to steal their secrets.',
    'picture': 'https://m.media-amazon.com/images/I/919mVr6ikcL._AC_UF1000,1000_QL80_.jpg'
  },
  {
    'id_film': 'F002',
    'judul': 'The Matrix',
    'genre': 'Action',
    'tahun_rilis': '1999',
    'sutradara': 'Wachowskis',
    'aktor': 'Keanu Reeves',
    'deskripsi': 'A hacker discovers a dystopian reality controlled by intelligent machines.',
    'picture': 'https://m.media-amazon.com/images/M/MV5BN2NmN2VhMTQtMDNiOS00NDlhLTliMjgtODE2ZTY0ODQyNDRhXkEyXkFqcGc@._V1_.jpg'
  },
  {
    'id_film': 'F003',
    'judul': 'The Godfather',
    'genre': 'Crime',
    'tahun_rilis': '1972',
    'sutradara': 'Francis Ford Coppola',
    'aktor': 'Marlon Brando',
    'deskripsi': 'The story of the powerful Italian-American crime family of Don Vito Corleone.',
    'picture': 'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg'
  }
];
