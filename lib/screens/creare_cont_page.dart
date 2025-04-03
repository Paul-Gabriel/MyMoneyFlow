import 'package:flutter/material.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/screens/inregistrare_page.dart';
import 'package:my_money_flow/services/api_service.dart';

class CreareContPage extends StatefulWidget {
  const CreareContPage({super.key});

  @override
  CreareContPageState createState() => CreareContPageState();
}

class CreareContPageState extends State<CreareContPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers pentru câmpuri
  final TextEditingController _numeController = TextEditingController();
  final TextEditingController _prenumeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _parolaController = TextEditingController();
  final TextEditingController _venitController = TextEditingController();
  final TextEditingController _procentNevoiController = TextEditingController();
  final TextEditingController _procentDorinteController =
      TextEditingController();
  final TextEditingController _procentEconomiiController =
      TextEditingController();

  @override
  void dispose() {
    // Eliberăm resursele controllerelor
    _numeController.dispose();
    _prenumeController.dispose();
    _emailController.dispose();
    _parolaController.dispose();
    _venitController.dispose();
    _procentNevoiController.dispose();
    _procentDorinteController.dispose();
    _procentEconomiiController.dispose();
    super.dispose();
  }

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
                    if (double.parse(value) <= 0) {
                      return 'Te rog introdu un numar mai mare ca 0';
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
                      return 'Te rog introdu un numar între 0 și 100';
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 100) {
                      return 'Te rog introdu un numar valid între 0 și 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere procent dorinte
                TextFormField(
                  controller: _procentDorinteController,
                  decoration:
                      const InputDecoration(labelText: 'Procent Dorinte'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru dorinte';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un numar între 0 și 100';
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 100) {
                      return 'Te rog introdu un numar valid între 0 și 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Introducere procent economii
                TextFormField(
                  controller: _procentEconomiiController,
                  decoration:
                      const InputDecoration(labelText: 'Procent Economii'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Te rog introdu un procent pentru economii';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Te rog introdu un numar între 0 și 100';
                    }
                    int procentEconomii = int.parse(value);
                    if (procentEconomii < 0 || procentEconomii > 100) {
                      return 'Te rog introdu un numar valid între 0 și 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Buton de creare user
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Calculează suma procentelor folosind valorile din controllere
                        int procentNevoi =
                            int.tryParse(_procentNevoiController.text) ?? 0;
                        int procentDorinte =
                            int.tryParse(_procentDorinteController.text) ?? 0;
                        int procentEconomii =
                            int.tryParse(_procentEconomiiController.text) ?? 0;
                        int sumaProcente =
                            procentNevoi + procentDorinte + procentEconomii;

                        if (sumaProcente != 100) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Procentele trebuie să însumeze 100%',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        } else {
                          // Save the user data
                          try {
                            await ApiService().createUser(User(
                              id: "",
                              nume: _numeController.text,
                              prenume: _prenumeController.text,
                              email: _emailController.text,
                              parola: _parolaController.text,
                              venit: double.parse(_venitController.text),
                              procentDorinte: procentDorinte,
                              procentNevoi: procentNevoi,
                              procentEconomi: procentEconomii,
                            ));
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Contul a fost creat')),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InregistrarePage()),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Contul nu a putut fi creat. Verificați datele introduse',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              );
                            }
                          }
                        }
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
