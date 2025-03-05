// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_money_flow/models/plata.dart';
import 'dart:convert';
import 'package:my_money_flow/services/api_service.dart';


class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  // Variables to store the exchange rates, selected currencies, and input data
  // Map<String, double> exchangeRates = {};
  // String? fromCurrency = 'USD';
  // String? toCurrency = 'EUR';
  // double amount = 1.0;
  // double convertedAmount = 0.0;
  int id = 0;
  List plati=[];

  // final List<String> mostUsedCurrencies = ['EUR', 'USD', 'GBP', 'AUD', 'CAD'];

  // @override
  // void initState() {
  //   super.initState();
  //   _loadExchangeRates();
  // }

  // Load exchange rates from Firestore
//  Future<void> _loadExchangeRates() async {
//   final snapshot = await FirebaseFirestore.instance
//       .collection('exchange_rates')
//       .get();

//   if (snapshot.docs.isNotEmpty) {
//     setState(() {
//       exchangeRates = {
//         for (var doc in snapshot.docs)
//           // Check if the 'rate_to_usd' field exists before accessing it
//           if (doc.data().containsKey('rate_to_usd')) 
//             doc['code']: (doc['rate_to_usd'] as num).toDouble() 
//           else
//             doc['code']: 0.0,  // Set a default value (0.0) if the field is missing
//       };
//     });
//     _calculateConversion();  // Recalculate conversion after loading rates
//   }
// }

  // // Function to calculate the converted amount
  // void _calculateConversion() {
  //   if (fromCurrency != null && toCurrency != null && exchangeRates.isNotEmpty) {
  //     final fromRate = exchangeRates[fromCurrency!]!;
  //     final toRate = exchangeRates[toCurrency!]!;
  //     setState(() {
  //       // Convert the amount from the selected "From" currency to "To" currency
  //       convertedAmount = (amount / fromRate) * toRate;
  //     });
  //   }
  // }

  // getPlati
  void _getPlati() async{
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/plati/$id'),
    );
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        plati = decode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for the amount to convert
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  id = int.tryParse(value) ?? 0;
                });
                ApiService().getPlatiByUser(id).then((platiList) {
                  setState(() {
                    plati.clear();
                    for (var i = 0; i < platiList.length; i++) {
                      plati.add(platiList[i]);
                    }
                  });
                });
                // ApiService().getPlatiByUser(id).then((platiList) {
                //   setState(() {
                //   plati = platiList;
                //   });
                // });
                // _getPlati();
                // _calculateConversion();  // Recalculate when the amount changes
              },
              decoration: const InputDecoration(
                labelText: 'id',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // // Dropdown for selecting the "From" currency
            // DropdownButton<String>(
            //   value: fromCurrency,
            //   onChanged: (newValue) {
            //     setState(() {
            //       fromCurrency = newValue;
            //     });
            //     _calculateConversion();  // Recalculate when the "From" currency changes
            //   },
            //   items: [
            //     // Section for most used currencies
            //     const DropdownMenuItem<String>(
            //       value: null,
            //       child: Text('--- Most Used Currencies ---'),
            //     ),
            //     ...mostUsedCurrencies.map((currency) {
            //       return DropdownMenuItem<String>(
            //         value: currency,
            //         child: Text(currency),
            //       );
            //     }).toList(),
            //     // Section for other currencies
            //     const DropdownMenuItem<String>(
            //       value: null,
            //       child: Text('--- Other Currencies ---'),
            //     ),
            //     // Dropdown for the other currencies
            //     ...exchangeRates.keys.where((currency) {
            //       return !mostUsedCurrencies.contains(currency);
            //     }).map((currency) {
            //       return DropdownMenuItem<String>(
            //         value: currency,
            //         child: Text(currency),
            //       );
            //     }).toList(),
            //   ],
            //   hint: const Text('Select From Currency'),
            // ),
            // const SizedBox(height: 16),

            // // Dropdown for selecting the "To" currency
            // DropdownButton<String>(
            //   value: toCurrency,
            //   onChanged: (newValue) {
            //     setState(() {
            //       toCurrency = newValue;
            //     });
            //     _calculateConversion();  // Recalculate when the "To" currency changes
            //   },
            //   items: [
            //     // Section for most used currencies
            //     const DropdownMenuItem<String>(
            //       value: null,
            //       child: Text('--- Most Used Currencies ---'),
            //     ),
            //     ...mostUsedCurrencies.map((currency) {
            //       return DropdownMenuItem<String>(
            //         value: currency,
            //         child: Text(currency),
            //       );
            //     }).toList(),
            //     // Section for other currencies
            //     const DropdownMenuItem<String>(
            //       value: null,
            //       child: Text('--- Other Currencies ---'),
            //     ),
            //     // Dropdown for the other currencies
            //     ...exchangeRates.keys.where((currency) {
            //       return !mostUsedCurrencies.contains(currency);
            //     }).map((currency) {
            //       return DropdownMenuItem<String>(
            //         value: currency,
            //         child: Text(currency),
            //       );
            //     }).toList(),
            //   ],
            //   hint: const Text('Select To Currency'),
            // ),
            // const SizedBox(height: 16),

            // // Display the result of the conversion
            // if (convertedAmount != 0.0)
            //   Text(
            //     'Converted Amount: ${convertedAmount.toStringAsFixed(2)} $toCurrency',
            //     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            
            // Display the result of the conversion
            Text(
              'id: $id',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Plati: $plati',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
