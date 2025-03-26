// ignore_for_file: unnecessary_getters_setters

class Plata {
  final int _id;
  final int _userId;
  double _suma;
  String _categorie; // Poți utiliza un enum dacă vrei să forțezi cele 3 opțiuni: 'dorinte', 'nevoi', 'economi'
  String _descriere;
  DateTime _data;

  Plata({
    required int id,
    required int userId,
    required double suma,
    required String categorie,
    required String descriere,
    required DateTime data,
  })  : _id = id,
        _userId = userId,
        _suma = suma,
        _categorie = categorie,
        _descriere = descriere,
        _data = data;

  int get id => _id;
  int get userId => _userId;
  double get suma => _suma;
  String get categorie => _categorie;
  String get descriere => _descriere;
  DateTime get data => _data;

  set suma(double value) {
    _suma = value;
  }

  set categorie(String value) {
    _categorie = value;
  }

  set descriere(String value) {
    _descriere = value;
  }

  set data(DateTime value) {
    _data = value;
  }

  factory Plata.fromJson(Map<String, dynamic> json) {
    return Plata(
      id: json['id'],
      userId: json['user_id'],
      suma: (json['suma'] as num).toDouble(),
      categorie: json['categorie'],
      descriere: json['descriere'],
      data: DateTime.parse(json['data']),
    );
  }

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
}
