import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/creare_plata_page.dart';
import 'package:my_money_flow/screens/grafice_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:my_money_flow/widgets/plati_table.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/screens/setari_page.dart';
import 'package:my_money_flow/screens/ai_chat_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AfisarePlatiPage extends StatefulWidget {
  const AfisarePlatiPage({super.key});

  @override
  AfisarePlatiPageState createState() => AfisarePlatiPageState();
}

class AfisarePlatiPageState extends State<AfisarePlatiPage> {
  List<Plata> plati = [];
  int year = DateTime.now().year;
  int month = DateTime.now().month;
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
          MaterialPageRoute(
              builder: (context) =>
                  AiChatPage(plati: _filterPlatiByMonth(plati, year, month))),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GraficePage(plati: _filterPlatiByMonth(plati, year, month))),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SetariPage(plati: _filterPlatiByMonth(plati, year, month))),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bun venit, ${user?.prenume}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.greenAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdaugarePlataPage()),
              ).then((_) {
                _fetchPlati();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.blueAccent),
            onPressed: _showFilterOptions,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
            onPressed: () async {
              _createPDF();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${_getMonthName(month)}, $year',
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
            icon: Icon(Icons.chat, color: Colors.green),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart, color: Colors.orange),
            label: 'Grafice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.blueGrey),
            label: 'Setări',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _createPDF() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _filterByCategory();
    _filterByDate(ascending: true);
    List<Plata> platiPDF = _filterPlatiByMonth(plati, year, month);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text('Raport plati',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 30),
              pw.Text('Nume: ${user?.nume ?? ''}'),
              pw.Text('Prenume: ${user?.prenume ?? ''}'),
              pw.Text(
                  'Data generarii raportului: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
              pw.Text(
                  'Perioada: 1/$month/$year - ${DateTime(year, month + 1, 0).day}/$month/$year'),
              pw.SizedBox(height: 10),
              pw.Text('Buget: ${user?.venit.toStringAsFixed(2) ?? ''} RON'),
              pw.Text(
                  'Bani ramasi: ${((user?.venit ?? 0) - platiPDF.fold(0.0, (sum, plata) => sum + plata.suma)).toStringAsFixed(2)} RON'),
              pw.Text(
                  'Cheltuieli totale: ${platiPDF.fold(0.0, (sum, plata) => sum + plata.suma).toStringAsFixed(2)} RON'),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text('Lista plati',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(4),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Categorie',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Descriere',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Suma',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Data',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  ...platiPDF.map((plata) {
                    return pw.TableRow(
                      children: [
                        pw.Text(' ${plata.categorie}'),
                        pw.Text(' ${plata.descriere}'),
                        pw.Text(' ${plata.suma.toStringAsFixed(2)}'),
                        pw.Text(
                            ' ${plata.data.day}/${plata.data.month}/${plata.data.year}'),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
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
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: year,
                      decoration: const InputDecoration(labelText: 'Anul'),
                      items: List.generate(
                        10,
                        (index) => DateTime.now().year - index,
                      ).map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          year = value ?? DateTime.now().year;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: month,
                      decoration: const InputDecoration(labelText: 'Luna'),
                      items:
                          List.generate(12, (index) => index + 1).map((month) {
                        return DropdownMenuItem<int>(
                          value: month,
                          child: Text(month.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          month = value ?? DateTime.now().month;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
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
      plati.sort((a, b) {
        const categoryOrder = ['nevoi', 'dorinte', 'economii'];
        int indexA = categoryOrder.indexOf(a.categorie.toLowerCase());
        int indexB = categoryOrder.indexOf(b.categorie.toLowerCase());
        return indexA.compareTo(indexB);
      });
    });
  }

  void _filterByAmount({required bool ascending}) {
    setState(() {
      plati.sort((a, b) =>
          ascending ? a.suma.compareTo(b.suma) : b.suma.compareTo(a.suma));
    });
  }

  void _filterByDate({required bool ascending}) {
    setState(() {
      plati.sort((a, b) =>
          ascending ? a.data.compareTo(b.data) : b.data.compareTo(a.data));
    });
  }

  List<Plata> _filterPlatiByMonth(List<Plata> allPlati, int year, int month) {
    return allPlati.where((plata) {
      return plata.data.year == year && plata.data.month == month;
    }).toList();
  }

  _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Ianuarie';
      case 2:
        return 'Februarie';
      case 3:
        return 'Martie';
      case 4:
        return 'Aprilie';
      case 5:
        return 'Mai';
      case 6:
        return 'Iunie';
      case 7:
        return 'Iulie';
      case 8:
        return 'August';
      case 9:
        return 'Septembrie';
      case 10:
        return 'Octombrie';
      case 11:
        return 'Noiembrie';
      case 12:
        return 'Decembrie';
      default:
        return '';
    }
  }
}
