import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:my_money_flow/models/plata.dart';

class GraficePage extends StatelessWidget {
  final List<Plata> plati;

  const GraficePage({super.key, required this.plati});
  
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Grafice'),
  //     ),
  //     body: Center(
  //       child: Text('No data available'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Plăți'),
      ),
      body: ListView.builder(
        itemCount: plati.length,
        itemBuilder: (context, index) {
          final plata = plati[index];
          return ListTile(
            title: Text(plata.categorie),
            subtitle: Text('${plata.data.toLocal()}'),
            trailing: Text('${plata.suma.toStringAsFixed(2)} RON'),
          );
        },
      ),
    );
  }
  
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Grafice'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: _buildCategoryChart(),
  //           ),
  //           const SizedBox(height: 16),
  //           Expanded(
  //             child: _buildMonthlyChart(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCategoryChart() {
  //   // Exemplu de utilizare a fl_chart pentru un grafic circular
  //   return PieChart(
  //     PieChartData(
  //       sections: plati.map((plata) {
  //         return PieChartSectionData(
  //           value: plata.suma,
  //           title: plata.categorie,
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  // Widget _buildMonthlyChart() {
  //   // Exemplu de utilizare a fl_chart pentru un grafic cu bare
  //   return BarChart(
  //     BarChartData(
  //       barGroups: _groupByMonth().entries.map((entry) {
  //         return BarChartGroupData(
  //           x: int.parse(entry.key.split('-')[1]), // Luna
  //           barRods: [
  //             BarChartRodData(toY: entry.value),
  //           ],
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  // Map<String, double> _groupByMonth() {
  //   final Map<String, double> groupedData = {};
  //   for (var plata in plati) {
  //     final month = '${plata.data.year}-${plata.data.month.toString().padLeft(2, '0')}';
  //     groupedData[month] = (groupedData[month] ?? 0) + plata.suma;
  //   }
  //   return groupedData;
  // }
}