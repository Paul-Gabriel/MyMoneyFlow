import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/screens/main_page.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
