// ignore_for_file: unnecessary_getters_setters

class User {
  final String _id; // Id-ul user-ului (privat)
  String _nume;
  String _prenume;
  String _email;
  String _parola;
  double _venit;
  int _procentNevoi;
  int _procentDorinte;
  int _procentEconomi;

  User({
    required String id,
    required String nume,
    required String prenume,
    required String email,
    required String parola,
    required double venit,
    required int procentNevoi,
    required int procentDorinte,
    required int procentEconomi,
  }) : _id = id,
       _nume = nume,
       _prenume = prenume,
       _email = email,
       _parola = parola,
       _venit = venit,
       _procentNevoi = procentNevoi,
       _procentDorinte = procentDorinte,
       _procentEconomi = procentEconomi;

  String get id => _id;
  String get nume => _nume;
  String get prenume => _prenume;
  String get email => _email;
  String get parola => _parola;
  double get venit => _venit;
  int get procentNevoi => _procentNevoi;
  int get procentDorinte => _procentDorinte;
  int get procentEconomi => _procentEconomi;
  
  set name(String value) {
    _nume = value;
  }

  set prenume(String value) {
    _prenume = value;
  }

  set email(String value) {
    _email = value;
  }

  set parola(String value) {
    _parola = value;
  }

  set venit(double value) {
    _venit = value;
  }

  set procentNevoi(int value) {
    _procentNevoi = value;
  }

  set procentDorinte(int value) {
    _procentDorinte = value;
  }

  set procentEconomi(int value) {
    _procentEconomi = value;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      nume: json['nume'],
      prenume: json['prenume'],
      email: json['email'],
      parola: json['parola'],
      venit: (json['venit'] as num).toDouble(),
      procentNevoi: (json['procentNecesitati'] as num).toInt(),
      procentDorinte: (json['procentDorinte'] as num).toInt(),
      procentEconomi: (json['procentEconomii'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': _id,
      'nume': _nume,
      'prenume': _prenume,
      'email': _email,
      'parola': _parola,
      'venit': _venit,
      'procentDorinte': _procentDorinte,
      'procentNecesitati': _procentNevoi,
      'procentEconomii': _procentEconomi,
    };
  }
}
