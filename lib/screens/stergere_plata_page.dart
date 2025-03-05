import 'package:flutter/material.dart';

class StergerePlataPage extends StatefulWidget {
  @override
  _StergerePlataPageState createState() => _StergerePlataPageState();
}

class _StergerePlataPageState extends State<StergerePlataPage> {
  final TextEditingController _idController = TextEditingController();

  void _deletePlataById() {
    final String id = _idController.text;
    if (id.isNotEmpty) {
      // Add your delete logic here
      print('Deleting plata with id: $id');
      // Clear the text field after deletion
      _idController.clear();
    } else {
      // Show an error message if the id is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stergere Plata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Enter Plata ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deletePlataById,
              child: Text('Delete Plata'),
            ),
          ],
        ),
      ),
    );
  }
}