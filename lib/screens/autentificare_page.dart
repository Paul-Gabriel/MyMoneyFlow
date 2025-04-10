import 'package:flutter/material.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/screens/afisare_plati_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class AutentificarePage extends StatefulWidget {
  const AutentificarePage({super.key});

  @override
  AutentificarePageState createState() => AutentificarePageState();
}

class AutentificarePageState extends State<AutentificarePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _errorMessage = null; // Clear any previous errors
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Campurile nu pot fi goale.";
      });
      return;
    } else {
      User? user;
      try {
        user = await ApiService().getUserByEmail(_emailController.text);
        // print("\n\n\nUser: $user\n\n\n");
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      }

      if (user != null &&
          user.parola == _passwordController.text &&
          user.confirmareEmail) {
        if (!mounted) return;

        // Save user data using UserProvider
        Provider.of<UserProvider>(context, listen: false).setUser(user);

        // Navigate to Menu Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AfisarePlatiPage(),
          ),
        );
      } else if (user == null) {
        setState(() {
          _errorMessage = "Nu exista niciun cont cu acest email asociat.";
        });
      } else if (user.parola != _passwordController.text) {
        setState(() {
          _errorMessage = "Parola incorecta.";
        });
      } else if (!user.confirmareEmail) {
        setState(() {
          _errorMessage = "Contul nu este confirmat.";
        });
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autentificare')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Parolă',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Intră în cont',
                  style: TextStyle(color: Color.fromARGB(255, 19, 44, 49))),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
