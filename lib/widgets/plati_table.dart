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
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Date')),
          ],
          rows: widget.plati.map((plata) {
            return DataRow(
              cells: [
                DataCell(Text(plata.categorie)),
                DataCell(Text(plata.descriere)),
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
              controller: TextEditingController(text: plata.descriere),
              decoration: const InputDecoration(labelText: 'Descriere'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                plata.descriere = value;
                }
              },
              ),
              TextField(
                controller: TextEditingController(text: plata.suma.toStringAsFixed(2)),
              decoration: const InputDecoration(labelText: 'Sumă'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value != '0' && value != '') {
                plata.suma = double.tryParse(value) ?? plata.suma;
                }
              },
              ),
              StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ElevatedButton(
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
                child: Text('Dată: ${DateFormat('dd-MM-yyyy').format(plata.data)}'),
                );
              },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anulare'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Stergere'),
              onPressed: () {
                setState(() {
                  widget.plati.removeWhere((item) => item.id == plata.id);
                  // widget.plati.remove(plata);
                  ApiService().deletePlata(plata.id);
                });
                // Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AfisarePlatiPage()),
                );
              },
            ),
            TextButton(
              child: const Text('Salvare'),
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