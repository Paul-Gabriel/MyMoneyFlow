import 'package:flutter/material.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/models/user.dart';

class EditareUserPage extends StatefulWidget {
  const EditareUserPage({super.key});

  @override
  EditareUserPageState createState() => EditareUserPageState();
}

class EditareUserPageState extends State<EditareUserPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numeController = TextEditingController();
  final TextEditingController _prenumeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _parolaController = TextEditingController();
  final TextEditingController _venitController = TextEditingController();
  final TextEditingController _procentDorinteController = TextEditingController();
  final TextEditingController _procentNevoiController = TextEditingController();
  final TextEditingController _procentEconomiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _numeController.text = user?.nume ?? '';
    _prenumeController.text = user?.prenume ?? '';
    _emailController.text = user?.email ?? '';
    _parolaController.text = user?.parola ?? '';
    _venitController.text = (user?.venit ?? 0).toStringAsFixed(2);
    _procentDorinteController.text = (user?.procentDorinte ?? 0).toString();
    _procentNevoiController.text = (user?.procentNevoi ?? 0).toString();
    _procentEconomiController.text = (user?.procentEconomi ?? 0).toString();
  }

  @override
  void dispose() {
    _numeController.dispose();
    _prenumeController.dispose();
    _emailController.dispose();
    _parolaController.dispose();
    _venitController.dispose();
    _procentDorinteController.dispose();
    _procentNevoiController.dispose();
    _procentEconomiController.dispose();
    super.dispose();
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
                  controller: _numeController,
                  decoration: const InputDecoration(labelText: 'Nume'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un nume';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere prenume
                TextFormField(
                  controller: _prenumeController,
                  decoration: const InputDecoration(labelText: 'Prenume'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un prenume';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Te rog introdu un email valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere parola
                TextFormField(
                  controller: _parolaController,
                  decoration: const InputDecoration(labelText: 'Parola'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu o parolă';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere venit
                TextFormField(
                  controller: _venitController,
                  decoration: const InputDecoration(labelText: 'Venit'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un venit';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Te rog introdu un numar valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere procent nevoi
                TextFormField(
                  controller: _procentNevoiController,
                  decoration: const InputDecoration(labelText: 'Procent Nevoi'),
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
                ),
                const SizedBox(height: 15),

                // Introducere procent dorinte
                TextFormField(
                  controller: _procentDorinteController,
                  decoration: const InputDecoration(labelText: 'Procent Dorințe'),
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
                ),
                const SizedBox(height: 15),

                // Introducere procent economii
                TextFormField(
                  controller: _procentEconomiController,
                  decoration: const InputDecoration(labelText: 'Procent Economii'),
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
                ),
                const SizedBox(height: 20),

                // Buton de actualizare user
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final updatedUser = User(
                        id: user?.id ?? '',
                        nume: _numeController.text,
                        prenume: _prenumeController.text,
                        email: _emailController.text,
                        parola: _parolaController.text,
                        venit: double.parse(_venitController.text),
                        procentDorinte: int.parse(_procentDorinteController.text),
                        procentNevoi: int.parse(_procentNevoiController.text),
                        procentEconomi: int.parse(_procentEconomiController.text),
                      );

                      try {
                        await ApiService().updateUser(updatedUser);
                        if (context.mounted) {
                          Provider.of<UserProvider>(context, listen: false).setUser(updatedUser);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User-ul a fost actualizat')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text(
                              'Eroare la actualizarea user-ului: $e',
                              style: const TextStyle(color: Colors.red),
                            ),
                            backgroundColor: Colors.black,
                            ),
                          );
                        }
                      }
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