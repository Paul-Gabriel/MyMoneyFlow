import 'package:flutter/material.dart';
import 'package:my_money_flow/screens/creare_cont_page.dart';
import 'inregistrare_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //Log In button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InregistrarePage()),
                );
              },
              child: const Text('Intră în cont'),
            ),
            const SizedBox(height: 16),

            //Creare User button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreareContPage()),
                );
              },
              child: const Text('Creare cont'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
