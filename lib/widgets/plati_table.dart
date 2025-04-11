import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/screens/afisare_plati_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class PlatiTable extends StatefulWidget {
  final List<Plata> plati;

  const PlatiTable({super.key, required this.plati});

  @override
  PlatiTableState createState() => PlatiTableState();
}

class PlatiTableState extends State<PlatiTable> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Permite derularea pe verticală
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Permite derularea pe orizontală
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Categorie')),
            DataColumn(label: Text('Descriere')),
            DataColumn(label: Text('Sumă')),
            DataColumn(label: Text('Dată')),
          ],
          rows: widget.plati.map((plata) {
            return DataRow(
              cells: [
                DataCell(Text(plata.categorie)),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Text(
                      utf8.decode(plata.descriere.codeUnits),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                DataCell(Text('${plata.suma.toStringAsFixed(2)} RON')),
                DataCell(Text(DateFormat('dd-MM-yyyy').format(plata.data))),
              ],
              onSelectChanged: (selected) {
                if (selected != null && selected) {
                  _showEditDialog(context, user, plata);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, User? user, Plata plata) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editare plată'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: plata.categorie,
                decoration: const InputDecoration(labelText: 'Categorie'),
                items: ['nevoi', 'dorinte', 'economii'].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    plata.categorie = value;
                  }
                },
              ),
              TextField(
                controller: TextEditingController(
                    text: utf8.decode(plata.descriere.codeUnits)),
                decoration: const InputDecoration(labelText: 'Descriere'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    plata.descriere = value;
                  }
                },
              ),
              TextField(
                controller:
                    TextEditingController(text: plata.suma.toStringAsFixed(2)),
                decoration: const InputDecoration(labelText: 'Sumă'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (double.tryParse(value) != null &&
                      double.parse(value) > 0) {
                    plata.suma = double.tryParse(value) ?? plata.suma;
                  }
                },
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return ElevatedButton.icon(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: plata.data,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          plata.data = selectedDate;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                        'Data: ${DateFormat('dd/MM/yyyy').format(plata.data)}'),
                  );
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Icon(Icons.cancel, color: Colors.blueGrey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  widget.plati.removeWhere((item) => item.id == plata.id);
                  ApiService().deletePlata(plata.id);
                });
                // Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AfisarePlatiPage()),
                );
              },
            ),
            TextButton(
              child: const Icon(Icons.edit,
                  color: Color.fromARGB(255, 220, 220, 0)),
              onPressed: () {
                setState(() {
                  ApiService().updatePlata(Plata(
                    id: plata.id,
                    userRef: plata.userId,
                    categorie: plata.categorie,
                    descriere: plata.descriere,
                    suma: plata.suma.toDouble(),
                    data: plata.data,
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
