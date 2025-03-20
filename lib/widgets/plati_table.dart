import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class PlatiTable extends StatefulWidget {
  final List<Map<String, dynamic>> plati;

  const PlatiTable({super.key, required this.plati});

  @override
  _PlatiTableState createState() => _PlatiTableState();
}

class _PlatiTableState extends State<PlatiTable> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          //DataColumn(label: Text('ID')),
          //DataColumn(label: Text('User ID')),
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Date')),
        ],
        rows: widget.plati.map((plata) {
          return DataRow(
            cells: [
              //DataCell(Text(plata['id'].toString())),
              //DataCell(Text(plata['user_id'].toString())),
              DataCell(Text(plata['categorie'])),
              DataCell(Text(plata['descriere'])),
              DataCell(Text('${plata['suma'].toStringAsFixed(2)} RON')),
              DataCell(Text(plata['data'].toString())),
            ],
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                _showEditDialog(context, user, plata);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  void _showEditDialog(BuildContext context, User? user,Map<String, dynamic> plata) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: plata['categorie']),
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) {
                  plata['categorie'] = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: plata['descriere']),
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  plata['descriere'] = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: plata['suma'].toString()),
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  plata['suma'] = int.tryParse(value) ?? plata['suma'];
                },
              ),
              TextField(
                controller: TextEditingController(text: plata['data']),
                decoration: const InputDecoration(labelText: 'Date'),
                onChanged: (value) {
                  plata['data'] = DateTime.tryParse(value) ?? plata['data'];
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  widget.plati.remove(plata);
                  ApiService().deletePlata(plata['id'], plata['user_id']);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                    ApiService().updatePlata(Plata(
                    id: plata['id'],
                    userId: plata['user_id'],
                    categorie: plata['categorie'],
                    descriere: plata['descriere'],
                    suma: plata['suma'].toInt(),
                    data: DateTime.parse(plata['data']),
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