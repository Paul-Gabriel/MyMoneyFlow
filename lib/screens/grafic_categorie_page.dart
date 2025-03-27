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
            SizedBox(
              height: 300, // Setăm o înălțime fixă pentru grafic
              child: PieChart(
                dataMap: {
                  'Rămas': remainingSum,
                  categorie == 'nevoi'
                      ? 'Consumat nevoi'
                      : categorie == 'dorinte'
                          ? 'Consumat dorințe'
                          : 'Consumat economii': totalSumPlati,
                },
                colorList: [
                  Colors.green,
                  categorie == 'nevoi'
                      ? Colors.blue
                      : categorie == 'dorinte'
                          ? Colors.yellow
                          : Colors.pink,
                ],
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 2,
                ),
                legendOptions: const LegendOptions(
                  showLegends: false,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Legendă personalizată
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem('Rămas', Colors.green, remainingSum),
                const SizedBox(height: 8),
                _buildLegendItem(
                  categorie == 'nevoi'
                      ? 'Consumat nevoi'
                      : categorie == 'dorinte'
                          ? 'Consumat dorințe'
                          : 'Consumat economii',
                  categorie == 'nevoi'
                      ? Colors.blue
                      : categorie == 'dorinte'
                          ? Colors.yellow
                          : Colors.pink,
                  totalSumPlati,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, double value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ${value.toStringAsFixed(2)} RON',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}