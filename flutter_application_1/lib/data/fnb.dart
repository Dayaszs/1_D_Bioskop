import 'dart:convert';

class Fnb {
  String? id_fnb;
  String? nama;
  String? deskripsi;
  int? harga;
  String? gambar;

  Fnb({this.id_fnb, this.nama, this.deskripsi, this.harga, this.gambar});

  factory Fnb.fromRawJson(String str) => Fnb.fromJson(json.decode(str));
  factory Fnb.fromJson(Map<String, dynamic> json) => Fnb(
    id_fnb: json["id_fnb"],
    nama: json["nama"],
    deskripsi: json["deskripsi"],
    harga: json["harga"],
    gambar: json["gambar"],
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id_fnb" : id_fnb,
    "nama" : nama,
    "deskripsi" : deskripsi,
    "harga" : harga,
    "gambar" : gambar,
  };
}

final List<Fnb> fnbs = _fnbs
    .map((e) => Fnb(
          id_fnb : e['id_fnb'] as String,
          nama : e['nama'] as String,
          deskripsi : e['deskripsi'] as String,
          harga : e['harga'] as int,
          gambar : e['gambar'] as String,
        ))
    .toList(growable: false);

final List<Map<String, Object>> _fnbs = [
  {
    'id_fnb': 'F001',
    'nama': 'Popcorn',
    'deskripsi': 'Special popcorn with sweet flavor',
    'harga': 30000,
    'gambar':
        'https://akcdn.detik.net.id/community/media/visual/2023/11/03/5-makanan-tak-sehat-yang-ternyata-berkhasiat-untuk-tubuh-ada-permen-dan-popcorn-4.jpeg?w=700&q=90'
  },
  {
    'id_fnb': 'F002',
    'nama': 'Burger Combo Super',
    'deskripsi': 'Special burger with double cheese and patty',
    'harga': 40000,
    'gambar': 'https://images.unsplash.com/photo-1550317138-10000687a72b'
  },
  {
    'id_fnb': 'F003',
    'nama': 'Hot Dog Deluxe',
    'deskripsi': 'Delicious hot dog with caramelized onions and mustard',
    'harga': 35000,
    'gambar': 'https://images.unsplash.com/photo-1562967916-eb82221dfb5c'
  },
  {
    'id_fnb': 'F004',
    'nama': 'Nachos Supreme',
    'deskripsi': 'Crispy nachos with melted cheese, jalapeños, and salsa',
    'harga': 45000,
    'gambar': 'https://images.unsplash.com/photo-1594007659711-ae9f4c838995'
  },
  {
    'id_fnb': 'F005',
    'nama': 'Fried Chicken Bucket',
    'deskripsi': 'Crispy and juicy fried chicken bucket for sharing',
    'harga': 60000,
    'gambar': 'https://images.unsplash.com/photo-1572748329431-9b2b7e3ca3e5'
  },
  {
    'id_fnb': 'F006',
    'nama': 'French Fries',
    'deskripsi': 'Crispy golden french fries with a hint of sea salt',
    'harga': 20000,
    'gambar': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0'
  },
  {
    'id_fnb': 'F007',
    'nama': 'Cheese Pizza',
    'deskripsi': 'Classic cheese pizza with a crispy crust',
    'harga': 55000,
    'gambar': 'https://images.unsplash.com/photo-1601924638867-3a7b40ef40f9'
  },
  {
    'id_fnb': 'F008',
    'nama': 'Iced Latte',
    'deskripsi': 'Refreshing iced latte with a smooth coffee flavor',
    'harga': 25000,
    'gambar': 'https://images.unsplash.com/photo-1564419421146-31a2fd5e1d32'
  },
  {
    'id_fnb': 'F009',
    'nama': 'Sundae Ice Cream',
    'deskripsi':
        'Vanilla ice cream sundae with chocolate syrup and sprinkles',
    'harga': 15000,
    'gambar': 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90'
  },
  {
    'id_fnb': 'F010',
    'nama': 'Taco Platter',
    'deskripsi': 'Soft tacos with a variety of fillings and sauces',
    'harga': 50000,
    'gambar': 'https://images.unsplash.com/photo-1548946526-f69e2424cf45'
  },
];
