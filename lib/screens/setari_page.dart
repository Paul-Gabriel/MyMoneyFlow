import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/editare_user_page.dart';
import 'package:my_money_flow/screens/main_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class SetariPage extends StatefulWidget {
  final List<Plata> plati;

  const SetariPage({super.key,required this.plati});

  @override
  SetariPageState createState() => SetariPageState();
}

class SetariPageState extends State<SetariPage> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final int procentNevoi = user?.procentNevoi ?? 0;
    final int procentDorinte = user?.procentDorinte ?? 0;
    final int procentEconomii = user?.procentEconomi ?? 0;
    final double totalSum = user?.venit ?? 0;
    final double nevoiSum = widget.plati
        .where((plata) => plata.categorie == 'nevoi')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double dorinteSum = widget.plati
        .where((plata) => plata.categorie == 'dorinte')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double economiiSum = widget.plati
        .where((plata) => plata.categorie == 'economii')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double remainingSum = totalSum - (nevoiSum + dorinteSum + economiiSum); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setări'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              Text('${user?.nume ?? 'Nume'} ${user?.prenume ?? 'Prenume'}'),
              SizedBox(height: 16),

              Text('Buget: $remainingSum RON din $totalSum RON'),
              Row(
                children: [
                  Expanded(
                  flex: (remainingSum / totalSum * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          '${(remainingSum / totalSum * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                  flex: ((totalSum-remainingSum) / totalSum * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          '${((totalSum-remainingSum) / totalSum * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text('Nevoi: $procentNevoi% -> ${totalSum * procentNevoi / 100 - nevoiSum} RON din ${totalSum * procentNevoi / 100} RON'),
              Row(
                children: [
                  Expanded(
                  flex: ((1 - nevoiSum / (totalSum * procentNevoi / 100)) * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          '${((1 - nevoiSum / (totalSum * procentNevoi / 100)) * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                  flex: ((nevoiSum / (totalSum * procentNevoi / 100)) * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          '${((nevoiSum / (totalSum * procentNevoi / 100)) * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text('Dorinte: $procentDorinte% -> ${totalSum * procentDorinte / 100 - dorinteSum} RON din ${totalSum *procentDorinte / 100} RON'),
              Row(
                children: [
                  Expanded(
                  flex: ((1 - dorinteSum / (totalSum * procentDorinte / 100)) * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          '${((1 - dorinteSum / (totalSum * procentDorinte / 100)) * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                  flex: ((dorinteSum / (totalSum * procentDorinte / 100)) * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          '${((dorinteSum / (totalSum * procentDorinte / 100)) * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text('Economii: $procentEconomii% -> ${totalSum * procentEconomii / 100 - economiiSum} RON din ${totalSum * procentEconomii / 100} RON'),
              Row(
                children: [
                  Expanded(
                  flex: ((1 - economiiSum / (totalSum * procentEconomii / 100)) * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          '${((1 - economiiSum / (totalSum * procentEconomii / 100)) * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                  flex: ((economiiSum / (totalSum * procentEconomii / 100)) * 100).round(),
                    child: Container(
                      height: 20,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          '${((economiiSum / (totalSum * procentEconomii / 100)) * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //button pentru editare user
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditareUserPage()),
                );
              },
              child: const Text('Actualizare date personale'),
              ),
              const SizedBox(height: 16),

              //button pentru stergere user
              ElevatedButton(
                onPressed: () async {
                  final List<Plata> platiList = await ApiService().getPlatiByUser(user?.id??-1);
                  if (platiList.isNotEmpty) {
                    for (var plata in platiList) {
                      ApiService().deletePlata(plata.id, plata.userId);
                    }
                  }
                  ApiService().deleteUser(user?.id ?? -1);
                  Provider.of<UserProvider>(context, listen: false).clearUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ștergere date...')),
                  );
                },
                child: const Text('Ștergere cont'),
              ),
              const SizedBox(height: 16),

              //button pentru delogare
              ElevatedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).clearUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ieșire din cont...')),
                  );
                },
                child: const Text('Ieșire din cont'),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}