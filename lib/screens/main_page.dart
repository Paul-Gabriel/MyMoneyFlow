import 'package:flutter/material.dart';
import 'package:my_money_flow/screens/creare_cont_page.dart';
import 'autentificare_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Main Page')),
      backgroundColor: const Color.fromARGB(255, 19, 44, 49),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo image
            Image.asset(
              'assets/logos/logo_final_cu_scris-removebg-preview.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image not found');
              },
            ),

            //Autentificare button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AutentificarePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    const Color.fromARGB(255, 19, 44, 49), // Text color
              ),
              icon: const Icon(Icons.login, color: Colors.blue),
              label: const Text('Autentificare'),
            ),
            const SizedBox(height: 16),

            //Creare User button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreareContPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    const Color.fromARGB(255, 19, 44, 49), // Text color
              ),
              icon: const Icon(Icons.person_add, color: Colors.green),
              label: const Text('Creare cont'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
