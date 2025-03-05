class User {
  final int? _id; // Id-ul este primit, dar nu va fi serializat către client
  final String nume;
  final String prenume;
  final String email;
  final String parola;
  final double venit;
  final double procentDorinte;
  final double procentNevoi;
  final double procentEconomi;

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

  // Primește id-ul din JSON, dar îl stochează într-un câmp privat
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nume: json['nume'],
      prenume: json['prenume'],
      email: json['email'],
      parola: json['parola'],
      venit: (json['venit'] as num).toDouble(),
      procentDorinte: (json['procent_dorinte'] as num).toDouble(),
      procentNevoi: (json['procent_nevoi'] as num).toDouble(),
      procentEconomi: (json['procent_economi'] as num).toDouble(),
    );
  }

  // Nu includem _id în toJson pentru a nu-l expune
  Map<String, dynamic> toJson() {
    return {
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

  String get name => name;
  int get id => id;
}
