// ignore_for_file: unnecessary_getters_setters

class Plata {
  final String _id;
  final String _userRef;
  double _suma;
  String
      _categorie; // Poți utiliza un enum dacă vrei să forțezi cele 3 opțiuni: 'dorinte', 'nevoi', 'economi'
  String _descriere;
  DateTime _data;

  Plata({
    required String id,
    required String userRef,
    required double suma,
    required String categorie,
    required String descriere,
    required DateTime data,
  })  : _id = id,
        _userRef = userRef,
        _suma = suma,
        _categorie = categorie,
        _descriere = descriere,
        _data = data;

  String get id => _id;
  String get userId => _userRef;
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
      id: json['plata_id'],
      userRef: json['user_ref'],
      suma: (json['suma'] as num).toDouble(),
      categorie: json['categorie'],
      descriere: json['descriere'],
      data: DateTime.parse(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': _id,
      'user_ref': _userRef,
      'suma': suma,
      'categorie': categorie,
      'descriere': descriere,
      'data': data.toIso8601String(),
    };
  }
}
