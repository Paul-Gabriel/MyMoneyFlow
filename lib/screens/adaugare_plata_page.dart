import 'package:flutter/material.dart';

class AdaugarePlataPage extends StatefulWidget {
  @override
  _AdaugarePlataPageState createState() => _AdaugarePlataPageState();
}

class _AdaugarePlataPageState extends State<AdaugarePlataPage> {
  final _formKey = GlobalKey<FormState>();
  late String _categorie;
  late String _descriere;
  late int _suma;
  late DateTime _data;

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
              TextFormField(
                decoration: InputDecoration(labelText: 'Categorie'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Te rog introdu o categorie';
                  }
                  return null;
                },
                onSaved: (value) {
                  _categorie = value as String;
                },
              ),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Save the payment data
                    // You can add your saving logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Plata a fost adaugata')),
                    );
                  }
                },
                child: Text('Adauga Plata'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}