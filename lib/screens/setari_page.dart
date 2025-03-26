import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/screens/editare_user_page.dart';
import 'package:my_money_flow/screens/main_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class SetariPage extends StatefulWidget {
  final List<Plata> plati;

  const SetariPage({super.key,required this.plati});

  @override
  SetariPageState createState() => SetariPageState();
}

class SetariPageState extends State<SetariPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setări'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('${user?.nume ?? 'Nume'} ${user?.prenume ?? 'Prenume'}'),
              Text('Buget: ${user?.venit ?? 0} RON din ${user?.venit ?? 0} RON'),
              Text('Nevoi: ${user?.procentNevoi ?? 0}% -> ${(user?.venit ?? 0)*(user?.procentNevoi ?? 0)/100-Plata.sumaPeCategorie(widget.plati,'nevoi')} RON din ${(user?.venit ?? 0)*(user?.procentNevoi ?? 0)/100} RON'),
              Text('Dorinte: ${user?.procentDorinte ?? 0}% -> ${(user?.venit ?? 0)*(user?.procentDorinte ?? 0)/100-Plata.sumaPeCategorie(widget.plati,'dorinte')} RON din ${(user?.venit ?? 0)*(user?.procentDorinte ?? 0)/100} RON'),
              Text('Economii: ${user?.procentEconomi ?? 0}% -> ${(user?.venit ?? 0)*(user?.procentEconomi ?? 0)/100-Plata.sumaPeCategorie(widget.plati,'economi')} RON din ${(user?.venit ?? 0)*(user?.procentEconomi ?? 0)/100} RON'),
              const SizedBox(height: 16),

              //button pentru editare user
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditareUserPage()),
                );
              },
              child: const Text('Actualizare date personale'),
              ),
              const SizedBox(height: 16),

              //button pentru stergere user
              ElevatedButton(
                onPressed: () async {
                  final List<Plata> platiList = await ApiService().getPlatiByUser(user?.id??-1);
                  if (platiList.isNotEmpty) {
                    for (var plata in platiList) {
                      ApiService().deletePlata(plata.id, plata.userId);
                    }
                  }
                  ApiService().deleteUser(user?.id ?? -1);
                  Provider.of<UserProvider>(context, listen: false).clearUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ștergere date...')),
                  );
                },
                child: const Text('Ștergere cont'),
              ),
              const SizedBox(height: 16),

              //button pentru delogare
              ElevatedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).clearUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ieșire din cont...')),
                  );
                },
                child: const Text('Ieșire din cont'),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}