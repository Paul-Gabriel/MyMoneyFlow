import 'package:flutter/material.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/models/user.dart';

class EditareUserPage extends StatefulWidget {
  const EditareUserPage({super.key});

  @override
  _EditareUserPageState createState() => _EditareUserPageState();
}

class _EditareUserPageState extends State<EditareUserPage> {
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
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _nume = user?.nume ?? '';
    _prenume = user?.prenume ?? '';
    _email = user?.email ?? '';
    _parola = user?.parola ?? '';
    _venit = user?.venit ?? 0;
    _procentDorinte = user?.procentDorinte ?? 0;
    _procentNevoi = user?.procentNevoi ?? 0;
    _procentEconomi = user?.procentEconomi ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editare cont'),
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
                  initialValue: _nume,
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
                  initialValue: _prenume,
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
                  initialValue: _email,
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
                  initialValue: _parola,
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
                  initialValue: _venit.toString(),
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
                  initialValue: _procentNevoi.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru nevoi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un număr valid';
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
                  decoration: const InputDecoration(labelText: 'Procent Dorințe'),
                  initialValue: _procentDorinte.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru dorințe';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un număr valid';
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
                  initialValue: _procentEconomi.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru economii';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un număr valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _procentEconomi = int.parse(value!);
                  },
                ),
                const SizedBox(height: 20),

                // Buton de actualizare user
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();

                      // Save the user data
                      final updatedUser = User(
                        id: user?.id ?? -1,
                        nume: _nume,
                        prenume: _prenume,
                        email: _email,
                        parola: _parola,
                        venit: _venit,
                        procentDorinte: _procentDorinte,
                        procentNevoi: _procentNevoi,
                        procentEconomi: _procentEconomi,
                      );

                      ApiService().updateUser(updatedUser);
                      
                       // Update the user in UserProvider
                      Provider.of<UserProvider>(context, listen: false).setUser(updatedUser);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User-ul a fost actualizat')),
                      );
                    }
                  },
                  child: const Text('Actualizare User'),
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