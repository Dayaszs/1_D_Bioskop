import 'dart:convert';

class Fnb {
  String? id_fnb;
  String? name;
  String? description;
  int? price;
  String? picture;

  Fnb({this.id_fnb, this.name, this.description, this.price, this.picture});

  factory Fnb.fromRawJson(String str) => Fnb.fromJson(json.decode(str));
  factory Fnb.fromJson(Map<String, dynamic> json) => Fnb(
    id_fnb: json["id_fnb"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    picture: json["picture"],
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id_fnb" : id_fnb,
    "name" : name,
    "description" : description,
    "price" : price,
    "picture" : picture,
  };
}

final List<Fnb> fnbs = _fnbs
    .map((e) => Fnb(
          id_fnb : e['id_fnb'] as String,
          name : e['name'] as String,
          description : e['description'] as String,
          price : e['price'] as int,
          picture : e['picture'] as String,
        ))
    .toList(growable: false);

final List<Map<String, Object>> _fnbs = [
  {
    'id_fnb': 'F001',
    'name': 'Popcorn',
    'description': 'Special popcorn with sweet flavor',
    'price': 30000,
    'picture':
        'https://akcdn.detik.net.id/community/media/visual/2023/11/03/5-makanan-tak-sehat-yang-ternyata-berkhasiat-untuk-tubuh-ada-permen-dan-popcorn-4.jpeg?w=700&q=90'
  },
  {
    'id_fnb': 'F002',
    'name': 'Burger Combo Super',
    'description': 'Special burger with double cheese and patty',
    'price': 40000,
    'picture': 'https://images.unsplash.com/photo-1550317138-10000687a72b'
  },
  {
    'id_fnb': 'F003',
    'name': 'Hot Dog Deluxe',
    'description': 'Delicious hot dog with caramelized onions and mustard',
    'price': 35000,
    'picture': 'https://images.unsplash.com/photo-1562967916-eb82221dfb5c'
  },
  {
    'id_fnb': 'F004',
    'name': 'Nachos Supreme',
    'description': 'Crispy nachos with melted cheese, jalapeños, and salsa',
    'price': 45000,
    'picture': 'https://images.unsplash.com/photo-1594007659711-ae9f4c838995'
  },
  {
    'id_fnb': 'F005',
    'name': 'Fried Chicken Bucket',
    'description': 'Crispy and juicy fried chicken bucket for sharing',
    'price': 60000,
    'picture': 'https://images.unsplash.com/photo-1572748329431-9b2b7e3ca3e5'
  },
  {
    'id_fnb': 'F006',
    'name': 'French Fries',
    'description': 'Crispy golden french fries with a hint of sea salt',
    'price': 20000,
    'picture': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0'
  },
  {
    'id_fnb': 'F007',
    'name': 'Cheese Pizza',
    'description': 'Classic cheese pizza with a crispy crust',
    'price': 55000,
    'picture': 'https://images.unsplash.com/photo-1601924638867-3a7b40ef40f9'
  },
  {
    'id_fnb': 'F008',
    'name': 'Iced Latte',
    'description': 'Refreshing iced latte with a smooth coffee flavor',
    'price': 25000,
    'picture': 'https://images.unsplash.com/photo-1564419421146-31a2fd5e1d32'
  },
  {
    'id_fnb': 'F009',
    'name': 'Sundae Ice Cream',
    'description':
        'Vanilla ice cream sundae with chocolate syrup and sprinkles',
    'price': 15000,
    'picture': 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90'
  },
  {
    'id_fnb': 'F010',
    'name': 'Taco Platter',
    'description': 'Soft tacos with a variety of fillings and sauces',
    'price': 50000,
    'picture': 'https://images.unsplash.com/photo-1548946526-f69e2424cf45'
  },
];
