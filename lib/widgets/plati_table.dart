import 'package:flutter/material.dart';

class PlatiTable extends StatelessWidget {
  final List<Map<String, dynamic>> plati;

  PlatiTable({required this.plati});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('User ID')),
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Amount')),
          //DataColumn(label: Text('Date')),
        ],
        rows: plati.map((plata) {
          return DataRow(cells: [
            DataCell(Text(plata['id'].toString())),
            DataCell(Text(plata['user_id'].toString())),
            DataCell(Text(plata['categorie'])),
            DataCell(Text(plata['descriere'])),
            DataCell(Text('${plata['suma'].toStringAsFixed(2)} RON')),
            // DataCell(Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(plata['date'])))),
          ]);
        }).toList(),
      ),
    );
  }
}