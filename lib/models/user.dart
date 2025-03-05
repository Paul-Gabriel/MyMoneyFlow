class User {
  final int? _id; // Id-ul user-ului (privat)
  final String nume;
  final String prenume;
  final String email;
  final String parola;
  final int venit;
  final int procentDorinte;
  final int procentNevoi;
  final int procentEconomi;

  User({
    int? id,
    required this.nume,
    required this.prenume,
    required this.email,
    required this.parola,
    required this.venit,
    required this.procentDorinte,
    required this.procentNevoi,
    required this.procentEconomi,
  }) : _id = id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nume: json['nume'],
      prenume: json['prenume'],
      email: json['email'],
      parola: json['parola'],
      venit: (json['venit'] as num).toInt(),
      procentDorinte: (json['procent_dorinte'] as num).toInt(),
      procentNevoi: (json['procent_nevoi'] as num).toInt(),
      procentEconomi: (json['procent_economi'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nume': nume,
      'prenume': prenume,
      'email': email,
      'parola': parola,
      'venit': venit,
      'procent_dorinte': procentDorinte,
      'procent_nevoi': procentNevoi,
      'procent_economi': procentEconomi,
    };
  }

}
