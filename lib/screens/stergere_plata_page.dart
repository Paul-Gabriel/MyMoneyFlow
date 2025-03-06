import 'package:flutter/material.dart';
import 'package:my_money_flow/services/api_service.dart';

class StergerePlataPage extends StatefulWidget {
  const StergerePlataPage({super.key});

  @override
  _StergerePlataPageState createState() => _StergerePlataPageState();
}

class _StergerePlataPageState extends State<StergerePlataPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  void _deletePlata() {
    final String id = _idController.text;
    final String userId = _userIdController.text;
    if (id.isNotEmpty) {

      // Add your delete logic here
      ApiService().deletePlata(int.parse(id), int.parse(userId));

      print('Deleting plata with id: $id');
      // Clear the text field after deletion
      _idController.clear();
      _userIdController.clear();
    } else {
      // Show an error message if the id is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stergere Plata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Enter plata ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'Enter user ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _deletePlata,
              child: const Text('Delete Plata'),
            ),
          ],
        ),
      ),
    );
  }
}