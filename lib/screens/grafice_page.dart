import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/screens/grafic_categorie_page.dart';
import 'package:provider/provider.dart';

class GraficePage extends StatelessWidget {
  final List<Plata> plati;

  const GraficePage({super.key, required this.plati});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafic general'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildLineChart(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance, color: Colors.blue),
            label: 'Nevoi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.yellow),
            label: 'Dorințe',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.savings,
              color: Colors.pinkAccent,
            ),
            label: 'Economii',
          ),
        ],
        onTap: (index) {
          // Navigăm către pagina corespunzătoare
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GraficCategoriePage(
                    categorie: 'nevoi',
                    plati: plati,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GraficCategoriePage(
                    categorie: 'dorinte',
                    plati: plati,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GraficCategoriePage(
                    categorie: 'economii',
                    plati: plati,
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }

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
        .where((plata) => plata.categorie == 'economii')
        .fold(0, (sum, plata) => sum + plata.suma);
    final double remainingSum =
        totalSum - (nevoiSum + dorinteSum + economiiSum);

    return Column(
      children: [
        const Text(
          'Distribuția cheltuielilor',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        SizedBox(
          child: PieChart(
            dataMap: {
              'Bani rămași: ${remainingSum.toStringAsFixed(2)} RON':
                  remainingSum,
              'Cheltuieli nevoi: ${nevoiSum.toStringAsFixed(2)} RON': nevoiSum,
              'Cheltuieli dorințe: ${dorinteSum.toStringAsFixed(2)} RON':
                  dorinteSum,
              'Cheltuieli economii: ${economiiSum.toStringAsFixed(2)} RON':
                  economiiSum,
            },
            animationDuration: const Duration(milliseconds: 1000),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 1.5,
            colorList: const [
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.pink,
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
    );
  }
}
