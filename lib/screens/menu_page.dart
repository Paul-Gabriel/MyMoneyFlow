import 'package:flutter/material.dart';
import 'package:my_money_flow/screens/a_i_chat_page.dart';
import 'package:my_money_flow/screens/adaugare_plata_page.dart';
import 'package:my_money_flow/screens/afisare_plati_page.dart';
import 'package:my_money_flow/screens/editare_plata_page.dart';
import 'package:my_money_flow/screens/main_page.dart';
import 'package:my_money_flow/screens/settings_page.dart';
import 'package:my_money_flow/screens/stergere_plata_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //Pagina de afisare a platilor
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AfisarePlatiPage()),
                );
              },
              child: const Text('Afisare plati'),
            ),
            const SizedBox(height: 16),

            //Pagina de adaugare a unei plati
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdaugarePlataPage()),
                );
              },
              child: const Text('Adaugare plata'),
            ),
            const SizedBox(height: 16),

            //Pagina de editare a unei plati
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditarePlataPage()),
                );
              },
              child: const Text('Editare plata'),
            ),
            const SizedBox(height: 16),

            //Pagina de editare a unei plati
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StergerePlataPage()),
                );
              },
              child: const Text('Stergere plata dupa ID'),
            ),
            const SizedBox(height: 16),

            //Pagina de chat cu AI
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AIChatPage()),
                );
              },
              child: const Text('AI Chat'),
            ),
            const SizedBox(height: 16),

            //Pagina de setari
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              child: const Text('Settings'),
            ),
            const SizedBox(height: 16),

            //Buton de log out care ne duce inapoi la pagina principala
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              child: const Text('Log out'),
            ),
            const SizedBox(height: 16),
            
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const RegisterPage()),
            //     );
            //   },
            //   child: const Text('Register'),
            // ),
          ],
        ),
      ),
    );
  }
}
