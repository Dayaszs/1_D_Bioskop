class Cinema {
  final String id_cinema;
  final String nama;
  final String lokasi;

  const Cinema(
      this.id_cinema,
      this.nama,
      this.lokasi);
}

final List<Cinema> cinema = _cinema
    .map((e) => Cinema(
          e['id_cinema'] as String,
          e['nama'] as String,
          e['lokasi'] as String
        )).toList(growable: false);

final List<Map<String, Object>> _cinema = [
  {
    'id_cinema' : '#C1',
    'nama' : 'Atma Cinema Amplaz',
    'lokasi' : 'Kab Sleman',
  }
];
