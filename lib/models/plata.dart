class Plata {
  final int? _id;      // Id-ul plății (privat)
  final int? _userId;  // Id-ul user-ului (privat)
  final int suma;
  final String categorie; // Poți utiliza un enum dacă vrei să forțezi cele 3 opțiuni: 'dorinte', 'nevoi', 'economi'
  final String descriere;
  final DateTime data;

  Plata({
    int? id,
    int? userId,
    required this.suma,
    required this.categorie,
    required this.descriere,
    required this.data,
  })  : _id = id,
        _userId = userId;

  // // Primește câmpurile private din JSON, dar le stochează intern
  // factory Plata.fromJson(Map<String, dynamic> json) {
  //   return Plata(
  //     id: json['id'],
  //     userId: json['user_id'],
  //     suma: (json['suma'] as num).toInt(),
  //     categorie: json['categorie'],
  //     descriere: json['descriere'],
  //     data: DateTime.parse(json['data']),
  //   );
  // }

  // Nu includem _id și _userId în toJson pentru a nu le expune
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'user_id': _userId,
      'suma': suma,
      'categorie': categorie,
      'descriere': descriere,
      'data': data.toIso8601String(),
    };
  }

  // Getters pentru a accesa câmpurile private
  int? get id => _id;
  int? get userId => _userId;
}
