import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/editare_user_page.dart';
import 'package:my_money_flow/screens/main_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class SetariPage extends StatefulWidget {
  final List<Plata> plati;

  const SetariPage({super.key, required this.plati});

  @override
  SetariPageState createState() => SetariPageState();
}

class SetariPageState extends State<SetariPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final String nume = user != null ? _reparaEncoding(user.nume) : '';
    final String prenume = user != null ? _reparaEncoding(user.prenume) : '';
    final int procentNevoi = user?.procentNevoi ?? -1;
    final int procentDorinte = user?.procentDorinte ?? -1;
    final int procentEconomii = user?.procentEconomi ?? -1;
    final double totalSum = user?.venit ?? -1;
    final double nevoiSum = widget.plati
        .where((plata) => plata.categorie == 'nevoi')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double dorinteSum = widget.plati
        .where((plata) => plata.categorie == 'dorinte')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double economiiSum = widget.plati
        .where((plata) => plata.categorie == 'economii')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double remainingSum =
        totalSum - (nevoiSum + dorinteSum + economiiSum);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setări'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  '$nume $prenume',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                const SizedBox(height: 30),

                Text('Buget: $remainingSum RON din $totalSum RON'),
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          if ((remainingSum / totalSum * 100).round() > 0)
                            Flexible(
                              flex: (remainingSum / totalSum * 100).round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          if (((totalSum - remainingSum) / totalSum * 100)
                                  .round() >
                              0)
                            Flexible(
                              flex: ((totalSum - remainingSum) / totalSum * 100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          '${(remainingSum / totalSum * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: (remainingSum / totalSum * 100).round() == 0
                                ? Colors.green
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        child: Text(
                          '${((totalSum - remainingSum) / totalSum * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((totalSum - remainingSum) / totalSum * 100)
                                        .round() ==
                                    0
                                ? Colors.red
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                    'Nevoi: $procentNevoi% -> ${totalSum * procentNevoi / 100 - nevoiSum} RON din ${totalSum * procentNevoi / 100} RON'),
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          if (((1 - nevoiSum / (totalSum * procentNevoi / 100)) *
                                  100)
                              .round() > 0)
                            Flexible(
                              flex: ((1 -
                                          nevoiSum /
                                              (totalSum * procentNevoi / 100)) *
                                      100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          if (((nevoiSum / (totalSum * procentNevoi / 100)) *
                                  100)
                              .round() > 0)
                            Flexible(
                              flex: ((nevoiSum /
                                          (totalSum * procentNevoi / 100)) *
                                      100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          '${((1 - nevoiSum / (totalSum * procentNevoi / 100)) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((1 -
                                            nevoiSum /
                                                (totalSum * procentNevoi / 100)) *
                                        100)
                                    .round() ==
                                0
                                ? Colors.green
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        child: Text(
                          '${((nevoiSum / (totalSum * procentNevoi / 100)) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((nevoiSum /
                                            (totalSum * procentNevoi / 100)) *
                                        100)
                                    .round() ==
                                0
                                ? Colors.red
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                    'Dorinte: $procentDorinte% -> ${totalSum * procentDorinte / 100 - dorinteSum} RON din ${totalSum * procentDorinte / 100} RON'),
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          if (((1 -
                                      dorinteSum /
                                          (totalSum * procentDorinte / 100)) *
                                  100)
                              .round() > 0)
                            Flexible(
                              flex: ((1 -
                                          dorinteSum /
                                              (totalSum * procentDorinte / 100)) *
                                      100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          if (((dorinteSum / (totalSum * procentDorinte / 100)) *
                                  100)
                              .round() > 0)
                            Flexible(
                              flex: ((dorinteSum /
                                          (totalSum * procentDorinte / 100)) *
                                      100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          '${((1 - dorinteSum / (totalSum * procentDorinte / 100)) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((1 -
                                            dorinteSum /
                                                (totalSum * procentDorinte / 100)) *
                                        100)
                                    .round() ==
                                0
                                ? Colors.green
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        child: Text(
                          '${((dorinteSum / (totalSum * procentDorinte / 100)) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((dorinteSum /
                                            (totalSum * procentDorinte / 100)) *
                                        100)
                                    .round() ==
                                0
                                ? Colors.red
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                    'Economii: $procentEconomii% -> ${totalSum * procentEconomii / 100 - economiiSum} RON din ${totalSum * procentEconomii / 100} RON'),
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          if (((1 -
                                      economiiSum /
                                          (totalSum * procentEconomii / 100)) *
                                  100)
                              .round() > 0)
                            Flexible(
                              flex: ((1 -
                                          economiiSum /
                                              (totalSum * procentEconomii / 100)) *
                                      100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          if (((economiiSum / (totalSum * procentEconomii / 100)) *
                                  100)
                              .round() > 0)
                            Flexible(
                              flex: ((economiiSum /
                                          (totalSum * procentEconomii / 100)) *
                                      100)
                                  .round(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          '${((1 - economiiSum / (totalSum * procentEconomii / 100)) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((1 -
                                            economiiSum /
                                                (totalSum * procentEconomii / 100)) *
                                        100)
                                    .round() ==
                                0
                                ? Colors.green
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        child: Text(
                          '${((economiiSum / (totalSum * procentEconomii / 100)) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ((economiiSum /
                                            (totalSum * procentEconomii / 100)) *
                                        100)
                                    .round() ==
                                0
                                ? Colors.red
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),

                //button pentru editare user
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditareUserPage()),
                    );
                  },
                  icon: const Icon(Icons.edit,
                      color: Color.fromARGB(255, 220, 220, 0)),
                  label: const Text('Actualizare profil'),
                ),
                const SizedBox(height: 16),

                //button pentru delogare
                ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .clearUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ieșire din cont...')),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.blue),
                  label: const Text('Ieșire din cont'),
                ),
                const SizedBox(height: 16),

                //button pentru stergere user
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmare'),
                          content:
                              const Text('Sigur dorești să ștergi contul?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Închide dialogul
                              },
                              child: const Text(
                                'Nu',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop(); // Închide dialogul
                                final List<Plata> platiList = await ApiService()
                                    .getPlatiByUser(user?.id ?? '');
                                if (platiList.isNotEmpty) {
                                  for (var plata in platiList) {
                                    ApiService().deletePlata(plata.id);
                                  }
                                }
                                ApiService().deleteUser(user?.id ?? '');
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MainPage()),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Ștergere date...')),
                                  );
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .clearUser();
                                }
                              },
                              child: const Text(
                                'Da',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Ștergere contul'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _reparaEncoding(String textStricat) {
  try {
    return utf8.decode(latin1.encode(textStricat));
  } catch (e) {
    return textStricat;
  }
}
