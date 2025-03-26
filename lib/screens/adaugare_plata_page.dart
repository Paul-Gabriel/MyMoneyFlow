import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
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
  final int _id=0;
  // late int _userId;
  late String _categorie;
  late String _descriere;
  late double _suma;
  DateTime _data = DateTime.now();

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
                        
              //Alegere categorie
                DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Categorie'),
                items: ['nevoi', 'dorinte', 'economi'].map((String category) {
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

              //Introducere descriere
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descriere'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu o descriere';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descriere = value  as String;
                },
              ),
              const SizedBox(height: 15),

              //Introducere suma
              TextFormField(
                decoration: const InputDecoration(labelText: 'Suma'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu o suma';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Te rog introdu un numar valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _suma = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),

              //Alegere data
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
                child: Text('Data: ${_data.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 20),

              //Buton de adaugare plata
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    // Save the payment data
                    if (user != null) {
                      ApiService().createPlata(Plata(id: _id, userId: user.id, suma: _suma, categorie: _categorie, descriere: _descriere, data: _data));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Userul nu este logat')),
                      );
                    }
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Plata a fost adaugata')),
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