import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:provider/provider.dart';

class GraficCategoriePage extends StatelessWidget {
  final String categorie;
  final List<Plata> plati;

  const GraficCategoriePage({super.key, required this.categorie, required this.plati});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final filteredPlati = plati.where((plata) => plata.categorie == categorie).toList();
    final double totalSumPlati = filteredPlati.fold(0, (sum, plata) => sum + plata.suma);
    double totalSumaCategorie = 0;

    switch (categorie) {
      case 'nevoi':
        totalSumaCategorie = user!.venit * user.procentNevoi / 100;
        break;
      case 'dorinte':
        totalSumaCategorie = user!.venit * user.procentDorinte / 100;
        break;
      case 'economii':
        totalSumaCategorie = user!.venit * user.procentEconomi / 100;
        break;
    }

    final double remainingSum = totalSumaCategorie - totalSumPlati;

    return Scaffold(
      appBar: AppBar(
        title: Text('Grafic $categorie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Distribuția cheltuielilor pentru $categorie',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              child: PieChart(
                dataMap: {
                  'Bani rămași: ${remainingSum.toStringAsFixed(2)} RON': remainingSum,
                  'Bani consumați: ${totalSumPlati.toStringAsFixed(2)} RON': totalSumPlati,
                },
                animationDuration: const Duration(milliseconds: 1000),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3,
                colorList: [
                  Colors.green,
                  if (categorie == 'nevoi') Colors.blue,
                  if (categorie == 'dorinte') Colors.yellow,
                  if (categorie == 'economii') Colors.pink,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                centerText: "",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  decimalPlaces: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}