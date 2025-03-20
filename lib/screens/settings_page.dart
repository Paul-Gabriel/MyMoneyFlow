import 'package:flutter/material.dart';
import 'package:my_money_flow/screens/editare_user_page.dart';
import 'package:my_money_flow/screens/main_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('${user?.name ?? 'Nume'} ${user?.prenume ?? 'Prenume'}'),
              Text('Buget: ${user?.venit ?? 0} RON'),
              Text('Nevoi: ${user?.procentNevoi ?? 0} %'),
              Text('Dorinte: ${user?.procentDorinte ?? 0} %'),
              Text('Economii: ${user?.procentEconomi ?? 0} %'),
              const SizedBox(height: 16),

              //button pentru editare user
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditareUserPage()),
                );
              },
              child: const Text('Actualizare date personale'),
              ),
              const SizedBox(height: 16),

              //button pentru stergere user
              ElevatedButton(
                onPressed: () async {
                  final platiList = await ApiService().getPlatiByUser(user?.id??-1);
                  if (platiList.isNotEmpty) {
                    for (var plata in platiList) {
                      ApiService().deletePlata(plata['id'],plata['user_id']);
                    }
                  }
                  ApiService().deleteUser(user?.id ?? -1);
                  Provider.of<UserProvider>(context, listen: false).logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Deleting user...')),
                  );
                },
                child: const Text('Delete user'),
              ),

              //button pentru delogare
              ElevatedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logging out...')),
                  );
                },
                child: const Text('Log out'),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}