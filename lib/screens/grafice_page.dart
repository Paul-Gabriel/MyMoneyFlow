import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:provider/provider.dart';

class GraficePage extends StatelessWidget {
  final List<Plata> plati;

  const GraficePage({super.key, required this.plati});

  Widget _buildLineChart(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final double totalSum = user?.venit ?? 0;
    final double nevoiSum = plati
        .where((plata) => plata.categorie == 'nevoi')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double dorinteSum = plati
        .where((plata) => plata.categorie == 'dorinte')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double economiiSum = plati
        .where((plata) => plata.categorie == 'economi')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double remainingSum = totalSum - (nevoiSum + dorinteSum + economiiSum);

    return Column(
      children: [
        const Text(
          'Distribuția cheltuielilor și economiilor',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: remainingSum,
                  color: Colors.green,
                  title: '', // Eliminăm textul din secțiune
                ),
                PieChartSectionData(
                  value: nevoiSum,
                  color: Colors.orange,
                  title: '', // Eliminăm textul din secțiune
                ),
                PieChartSectionData(
                  value: dorinteSum,
                  color: Colors.yellow,
                  title: '', // Eliminăm textul din secțiune
                ),
                PieChartSectionData(
                  value: economiiSum,
                  color: Colors.red,
                  title: '', // Eliminăm textul din secțiune
                ),
              ],
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Legendă personalizată
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildLegendItem('Rămas', Colors.green, remainingSum),
            _buildLegendItem('Nevoi', Colors.orange, nevoiSum),
            _buildLegendItem('Dorințe', Colors.yellow, dorinteSum),
            _buildLegendItem('Economii', Colors.red, economiiSum),
          ],
        ),
      ],
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
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildLineChart(context),
      ),
    );
  }
}