import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/services/api_service.dart';

class EditarePlataPage extends StatefulWidget {
  @override
  _EditarePlataPageState createState() => _EditarePlataPageState();
}

class _EditarePlataPageState extends State<EditarePlataPage> {
  final _formKey = GlobalKey<FormState>();
  int _id=0;
  late int _userId;
  late String _categorie;
  late String _descriere;
  late int _suma;
   DateTime _data = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adaugare Plata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              
              //Introducere User ID
              TextFormField(
                decoration: InputDecoration(labelText: 'User ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu un user ID valid';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Te rog introdu un numar valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userId = int.parse(value!);
                },
              ),
              SizedBox(height: 15),

              //Alegere categorie
                DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Categorie'),
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
              SizedBox(height: 15),

              //Introducere descriere
              TextFormField(
                decoration: InputDecoration(labelText: 'Descriere'),
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
              SizedBox(height: 15),

              //Introducere suma
              TextFormField(
                decoration: InputDecoration(labelText: 'Suma'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu o suma';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Te rog introdu un numar valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _suma = int.parse(value!);
                },
              ),
              SizedBox(height: 20),

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
                child: Text(_data == null
                    ? 'Selecteaza Data'
                    : 'Data: ${_data.toLocal()}'.split(' ')[0]),
              ),
              SizedBox(height: 20),

              //Buton de adaugare plata
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    // Save the payment data
                    ApiService().createPlata(Plata(id: _id,userId: _userId, suma: _suma, categorie: _categorie, descriere: _descriere, data: _data));
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Plata a fost adaugata')),
                    );
                  }
                },
                child: Text('Adauga Plata'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}