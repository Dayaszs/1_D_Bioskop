import 'dart:ffi';

class Film {
  final String id_film;
  final String judul;
  final String genre;
  final String tahun_rilis;
  final String sutradara;
  final String aktor;
  final String deskripsi;
  final String picture;
  final String horizontal_picture;
  final double? ratings;
  final String? review;
  final String trailer;

  const Film(
    this.id_film,
    this.judul,
    this.genre,
    this.tahun_rilis,
    this.sutradara,
    this.aktor,
    this.deskripsi,
    this.picture,
    this.horizontal_picture,
    this.ratings,
    this.review,
    this.trailer
  );
}

final List<Film> films = _films.map((e) => Film(
  e['id_film'] as String,
  e['judul'] as String,
  e['genre'] as String,
  e['tahun_rilis'] as String,
  e['sutradara'] as String,
  e['aktor'] as String,
  e['deskripsi'] as String,
  e['picture'] as String,
  e['horizontal_picture'] as String,
  e['ratings'] as double? ?? 0.0,
  e['review'] as String? ?? 'No reviews available',
  e['trailer'] as String
)).toList(growable: false);

final List<Map<String, Object>> _films = [
  {
    'id_film': 'F001',
    'judul': 'Inception',
    'genre': 'Sci-Fi',
    'tahun_rilis': '2010',
    'sutradara': 'Christopher Nolan',
    'aktor': 'Leonardo DiCaprio',
    'deskripsi': 'A thief who enters the dreams of others to steal their secrets.',
    'picture': 'https://m.media-amazon.com/images/I/919mVr6ikcL._AC_UF1000,1000_QL80_.jpg',
    'horizontal_picture': 'https://filmwonk.net/wp-content/uploads/2011/01/2010glennies-bp-10-inception.jpg?w=848',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
    'trailer': 'https://www.youtube.com/watch?v=YoHD9XEInc0'
  },
  {
    'id_film': 'F002',
    'judul': 'The Matrix',
    'genre': 'Action',
    'tahun_rilis': '1999',
    'sutradara': 'Wachowskis',
    'aktor': 'Keanu Reeves',
    'deskripsi': 'A hacker discovers a dystopian reality controlled by intelligent machines.',
    'picture': 'https://m.media-amazon.com/images/M/MV5BN2NmN2VhMTQtMDNiOS00NDlhLTliMjgtODE2ZTY0ODQyNDRhXkEyXkFqcGc@._V1_.jpg',
    'horizontal_picture': 'https://img.englishcinemakyiv.com/BVZBaq6fsTow7KZmdNWUFoEOT1GThWYfAprhqMDZEi4/resize:fill:800:450:1:0/gravity:sm/aHR0cHM6Ly9leHBhdGNpbmVtYXByb2QuYmxvYi5jb3JlLndpbmRvd3MubmV0L2ltYWdlcy9lMTA1YjhlNi1hOTcyLTQxMmMtYmRiMy0yZmJkYWE1NDA2OWYuanBn.jpg',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
  {
    'id_film': 'F003',
    'judul': 'The Godfather',
    'genre': 'Crime',
    'tahun_rilis': '1972',
    'sutradara': 'Francis Ford Coppola',
    'aktor': 'Marlon Brando',
    'deskripsi': 'The story of the powerful Italian-American crime family of Don Vito Corleone.',
    'picture': 'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg',
    'horizontal_picture': 'https://cdn.europosters.eu/image/750/962.jpg',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
  {
    'id_film': 'F004',
    'judul': 'The Shawshank Redemption',
    'genre': 'Drama',
    'tahun_rilis': '1994',
    'sutradara': 'Frank Darabont',
    'aktor': 'Tim Robbins',
    'deskripsi': 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
    'picture': 'https://upload.wikimedia.org/wikipedia/id/8/81/ShawshankRedemptionMoviePoster.jpg',
    'horizontal_picture': 'https://m.media-amazon.com/images/I/51whqgtGA4L._AC_UF1000,1000_QL80_.jpg',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
  {
    'id_film': 'F005',
    'judul': 'The Dark Knight',
    'genre': 'Action',
    'tahun_rilis': '2008',
    'sutradara': 'Christopher Nolan',
    'aktor': 'Christian Bale',
    'deskripsi': 'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
    'picture': 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQabt5_iESscctssvn8VxDbvnV7i9C42UyLOCWkFdqwJQE0VZYeg2qcXEcYYLh8td8Zna3zA5Nrk7s7SDElRyhKYiIf2AwvJ7F3mKVis5c',
    'horizontal_picture': 'https://rukminim2.flixcart.com/image/850/1000/jbfe7ww0-1/poster/g/k/c/medium-ashd-wall-poster-batman-the-dark-knight-bat-signal-original-imaet2nugm94hvyj.jpeg?q=20&crop=false',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
  {
    'id_film': 'F006',
    'judul': 'Forrest Gump',
    'genre': 'Drama',
    'tahun_rilis': '1994',
    'sutradara': 'Robert Zemeckis',
    'aktor': 'Tom Hanks',
    'deskripsi': 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal, and other historical events unfold through the perspective of an Alabama man with an IQ of 75.',
    'picture': 'https://m.media-amazon.com/images/I/91++WV6FP4L._AC_UF894,1000_QL80_.jpg',
    'horizontal_picture': 'https://www.gemakeadilan.com/storage/public/posts/images/o2Cw26lTlwGhn4gXDpC9b4SXlHNGHSuPUD3tqYOf.jpg',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
  {
    'id_film': 'F007',
    'judul': 'The Grand Budapest Hotel',
    'genre': 'Comedy, Drama',
    'tahun_rilis': '2014',
    'sutradara': 'Wes Anderson',
    'aktor': 'Ralph Fiennes',
    'deskripsi': 'A writer encounters the owner of an aging high-class hotel, who tells him of his early years serving as a lobby boy in the hotel\'s glorious years under an exceptional concierge.',
    'picture': 'https://upload.wikimedia.org/wikipedia/id/a/a4/Grand_Budapest_Hotel_Movie_Poster.jpg',
    'horizontal_picture': 'https://m.media-amazon.com/images/I/71JiBJhmqFL._AC_UF1000,1000_QL80_.jpg',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
  {
    'id_film': 'F008',
    'judul': 'Parasite',
    'genre': 'Thriller, Drama',
    'tahun_rilis': '2019',
    'sutradara': 'Bong Joon Ho',
    'aktor': 'Song Kang-ho, Lee Sun-kyun',
    'deskripsi': 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
    'picture': 'https://m.media-amazon.com/images/I/81cYnCyFCYL._AC_UF1000,1000_QL80_.jpg',
    'horizontal_picture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIe6fStcXDp9LGWEWihgvJ63CsSLKq0g_BWg&s',
    'ratings': 4.8,
    'review': 'A mind-bending thriller with stunning visuals and a complex plot.',
  },
];
