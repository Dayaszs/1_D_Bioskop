class Penayangan {
  final String id_penayangan;
  final String id_film;
  final String id_sesi;
  final String id_studio;
  final String nomor_kursi_tersedia;
  final String nomor_kursi_terpakai;
  final double harga_tiket;
  final String status;
  final DateTime tanggal_tayang;

  const Penayangan(
      this.id_penayangan,
      this.id_film,
      this.id_sesi,
      this.id_studio,
      this.nomor_kursi_tersedia,
      this.nomor_kursi_terpakai,
      this.harga_tiket,
      this.status,
      this.tanggal_tayang);
}

final List<Penayangan> penayangan = _penayangan
    .map((e) => Penayangan(
          e['id_penayangan'] as String,
          e['id_film'] as String,
          e['id_sesi'] as String,
          e['id_studio'] as String,
          e['nomor_kursi_tersedia'] as String,
          e['nomor_kursi_terpakai'] as String,
          e['harga_tiket'] as double,
          e['status'] as String,
          e['tanggal_tayang'] as DateTime,
        )).toList(growable: false);

final List<Map<String, Object>> _penayangan = [
  {
    'id_penayangan' : '#P1',
    'id_film' : '#F1',
    'id_sesi' : '#SE1',
    'id_studio' : '#S1',
    'nomor_kursi_tersedia' : 'A2, A3, A4, A5, A6, A7, A8, A9, A10, B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, C1, C2, C4, C5, C6, C7, C8, C9, C10, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, H1, H2, H3, H4, H5, H6, H7, H8, H9, I1, I2, I3, I5, I6, I7, I8, I9, I10, J1, J2, J3, J4, J5, J6, J7, J8, J9, J10',
    'nomor_kursi_terpakai' : 'A1, C3, H10, I4',
    'harga_tiket' : 50000.00,
    'status' : 'active',
    'tanggal_tayang' : DateTime(2024, 10, 19),
  }
];
