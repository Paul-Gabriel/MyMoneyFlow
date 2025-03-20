// Example usage in another page
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Another Page')),
      body: Center(
        child: Text('Welcome, ${user?.name ?? 'Guest'} (ID: ${user?.id ?? 'N/A'})'),
      ),
    );
  }
}