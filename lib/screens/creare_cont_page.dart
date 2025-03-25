import 'package:flutter/material.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/services/api_service.dart';

class CreareContPage extends StatefulWidget {
  const CreareContPage({super.key});

  @override
  _CreareContPageState createState() => _CreareContPageState();
}

class _CreareContPageState extends State<CreareContPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nume;
  late String _prenume;
  late String _email;
  late String _parola;
  late int _venit;
  late int _procentDorinte;
  late int _procentNevoi;
  late int _procentEconomi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creare cont'),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Introducere nume
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nume'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un nume';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nume = value!;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere prenume
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Prenume'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un prenume';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _prenume = value!;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere email
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un mail';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Te rog introdu un mail valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere parola
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Parola'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu o parolă';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _parola = value!;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere venit
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Venit'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un venit';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un numar valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _venit = int.parse(value!);
                  },
                ),
                const SizedBox(height: 15),

                // Introducere procent nevoi
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Procent Nevoi'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru nevoi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un numar valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _procentNevoi = int.parse(value!);
                  },
                ),
                const SizedBox(height: 15),

                // Introducere procent dorinte
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Procent Dorinte'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru dorinte';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un numar valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _procentDorinte = int.parse(value!);
                  },
                ),
                const SizedBox(height: 15),

                // Introducere procent economii
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Procent Economii'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru economii';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un numar valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _procentEconomi = int.parse(value!);
                  },
                ),
                const SizedBox(height: 20),

                // Buton de creare user
                Center(
                  child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    // Save the user data
                    ApiService().createUser(User(
                      id: 0,
                      nume: _nume,
                      prenume: _prenume,
                      email: _email,
                      parola: _parola,
                      venit: _venit,
                      procentDorinte: _procentDorinte,
                      procentNevoi: _procentNevoi,
                      procentEconomi: _procentEconomi,
                    ));
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contul a fost creat')),
                    );
                    }
                  },
                  child: const Text('Creare cont'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}