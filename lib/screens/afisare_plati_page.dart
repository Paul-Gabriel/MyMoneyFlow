import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/adaugare_plata_page.dart';
import 'package:my_money_flow/screens/grafice_page.dart';
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
  final int year = DateTime.now().year;
  final int month = DateTime.now().month;
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
          MaterialPageRoute(builder: (context) => AiChatPage(plati: _filterPlatiByMonth(plati, year, month))),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GraficePage(plati: _filterPlatiByMonth(plati, year, month))),
        );
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
        actions: [
            IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdaugarePlataPage()),
              ).then((_) {
              _fetchPlati();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bun venit ${user?.prenume}!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PlatiTable(plati: _filterPlatiByMonth(plati, year, month)),
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
            icon: Icon(Icons.pie_chart),
            label: 'Grafice',
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

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filtrează plățile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Categorie'),
                onTap: () {
                  _filterByCategory();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Sumă (Ascendent)'),
                onTap: () {
                  _filterByAmount(ascending: true);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Sumă (Descendent)'),
                onTap: () {
                  _filterByAmount(ascending: false);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Dată (Ascendent)'),
                onTap: () {
                  _filterByDate(ascending: true);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Dată (Descendent)'),
                onTap: () {
                  _filterByDate(ascending: false);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterByCategory() {
    setState(() {
      plati.sort((a, b) => a.categorie.compareTo(b.categorie));
    });
  }

  void _filterByAmount({required bool ascending}) {
    setState(() {
      plati.sort((a, b) => ascending ? a.suma.compareTo(b.suma) : b.suma.compareTo(a.suma));
    });
  }

  void _filterByDate({required bool ascending}) {
    setState(() {
      plati.sort((a, b) => ascending ? a.data.compareTo(b.data) : b.data.compareTo(a.data));
    });
  }

  List<Plata> _filterPlatiByMonth(List<Plata> allPlati, int year,int month) {
    return allPlati.where((plata) {
      return plata.data.year == year && plata.data.month == month;
    }).toList();
  }
}
