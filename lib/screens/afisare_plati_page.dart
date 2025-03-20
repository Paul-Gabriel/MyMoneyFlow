// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_money_flow/models/plata.dart';
// import 'dart:convert';
import 'package:my_money_flow/services/api_service.dart';
import 'package:my_money_flow/widgets/plati_table.dart'; // Import the PlatiTable widget
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';


class AfisarePlatiPage extends StatefulWidget {
  const AfisarePlatiPage({super.key});

  @override
  _AfisarePlatiPageState createState() => _AfisarePlatiPageState();
}

class _AfisarePlatiPageState extends State<AfisarePlatiPage> {
  int id = 0;
  List plati=[];

  // void _getPlati() async{
  //   final response = await http.get(
  //     Uri.parse('http://10.0.2.2:8000/plati/$id'),
  //   );
  //   var decode = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       plati = decode;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    ApiService().getPlatiByUser(user?.id??-1).then((platiList) {
      setState(() {
        plati.clear();
        for (var i = 0; i < platiList.length; i++) {
          plati.add(platiList[i]);
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plati'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the user's name
            Text(
              'Plati ${user?.nume} ${user?.prenume}:',
              // 'id: $id',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Display the plati table
            Expanded(
              child: PlatiTable(plati: plati.cast<Map<String, dynamic>>()),
            ),
          ],
        ),
      ),
    );
  }
}
