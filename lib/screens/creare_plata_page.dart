import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/afisare_plati_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class AdaugarePlataPage extends StatefulWidget {
  const AdaugarePlataPage({super.key});

  @override
  AdaugarePlataPageState createState() => AdaugarePlataPageState();
}

class AdaugarePlataPageState extends State<AdaugarePlataPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriereController = TextEditingController();
  final TextEditingController _sumaController = TextEditingController();
  late String _categorie;
  DateTime _data = DateTime.now();

  @override
  void dispose() {
    _descriereController.dispose();
    _sumaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaugare Plata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Alegere categorie
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Categorie'),
                items: ['nevoi', 'dorinte', 'economii'].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog alege o categorie';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _categorie = value!;
                  });
                },
                onSaved: (value) {
                  _categorie = value!;
                },
              ),
              const SizedBox(height: 15),

              // Introducere descriere
              TextFormField(
                controller: _descriereController,
                decoration: const InputDecoration(labelText: 'Descriere'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu o descriere';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Introducere suma
              TextFormField(
                controller: _sumaController,
                decoration: const InputDecoration(labelText: 'Suma'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu o suma';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Te rog introdu un numar valid';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Te rog introdu o suma mai mare decat 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Alegere data
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _data = selectedDate;
                    });
                  }
                },
                child: Text('Data: ${_data.toLocal().toString().split(' ')[0]}'),
              ),
              const SizedBox(height: 20),

              // Buton de adaugare plata
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    // Save the payment data
                    if (user != null) {
                      ApiService().createPlata(
                        Plata(
                          id: '',
                          userRef: user.id,
                          suma: double.parse(_sumaController.text),
                          categorie: _categorie,
                          descriere: _descriereController.text,
                          data: _data,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Userul nu este logat')),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Plata a fost adaugata')),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AfisarePlatiPage()),
                    );
                  }
                },
                child: const Text('Adauga Plata'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}