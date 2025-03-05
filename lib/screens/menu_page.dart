import 'package:flutter/material.dart';
import 'package:my_money_flow/screens/a_i_chat_page.dart';
import 'package:my_money_flow/screens/adaugare_plata_page.dart';
import 'package:my_money_flow/screens/currency_conversion_page.dart';
import 'package:my_money_flow/screens/main_page.dart';
import 'package:my_money_flow/screens/settings_page.dart';

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

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrencyConverterPage()),
                );
              },
              child: const Text('Currency Converter'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdaugarePlataPage()),
                );
              },
              child: const Text('Adaugare plata'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AIChatPage()),
                );
              },
              child: const Text('AI Chat'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: const Text('Settings'),
            ),
            const SizedBox(height: 16),

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
