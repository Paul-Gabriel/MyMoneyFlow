import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/adaugare_plata_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:my_money_flow/widgets/plati_table.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/screens/setari_page.dart';
import 'package:my_money_flow/screens/ai_chat_page.dart';

class AfisarePlatiPage extends StatefulWidget {
  const AfisarePlatiPage({super.key});

  @override
  AfisarePlatiPageState createState() => AfisarePlatiPageState();
}

class AfisarePlatiPageState extends State<AfisarePlatiPage> {
  List<Plata> plati = [];
  late int id;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPlati();
    });
  }

  void _fetchPlati() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      final platiList = await ApiService().getPlatiByUser(user.id);
      setState(() {
        plati = platiList;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AiChatPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
            MaterialPageRoute(builder: (context) => const AdaugarePlataPage()),
          ).then((_) {
            _fetchPlati();
          });
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SetariPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plăți'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Plăți ${user?.nume} ${user?.prenume}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PlatiTable(plati: plati),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adaugare Plata',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setări',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
