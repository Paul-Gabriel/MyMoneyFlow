class User {
  final int _id; // Id-ul user-ului (privat)
  String _nume;
  String _prenume;
  String _email;
  String _parola;
  int _venit;
  int _procentDorinte;
  int _procentNevoi;
  int _procentEconomi;

  User({
    required int id,
    required String nume,
    required String prenume,
    required String email,
    required String parola,
    required int venit,
    required int procentDorinte,
    required int procentNevoi,
    required int procentEconomi,
  }) : _id = id,
       _nume = nume,
       _prenume = prenume,
       _email = email,
       _parola = parola,
       _venit = venit,
       _procentDorinte = procentDorinte,
       _procentNevoi = procentNevoi,
       _procentEconomi = procentEconomi;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nume: json['nume'],
      prenume: json['prenume'],
      email: json['email'],
      parola: json['parola'],
      venit: (json['venit'] as num).toInt(),
      procentDorinte: (json['dorinte'] as num).toInt(),
      procentNevoi: (json['necesitati'] as num).toInt(),
      procentEconomi: (json['economii'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nume': _nume,
      'prenume': _prenume,
      'email': _email,
      'parola': _parola,
      'venit': _venit,
      'dorinte': _procentDorinte,
      'necesitati': _procentNevoi,
      'economii': _procentEconomi,
    };
  }

  int get id => _id;
  String get nume => _nume;
  String get prenume => _prenume;
  String get email => _email;
  String get parola => _parola;
  int get venit => _venit;
  int get procentDorinte => _procentDorinte;
  int get procentNevoi => _procentNevoi;
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

  set venit(int value) {
    _venit = value;
  }

  set procentDorinte(int value) {
    _procentDorinte = value;
  }

  set procentNevoi(int value) {
    _procentNevoi = value;
  }

  set procentEconomi(int value) {
    _procentEconomi = value;
  }
}
