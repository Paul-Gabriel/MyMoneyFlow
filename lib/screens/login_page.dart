import 'package:flutter/material.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/screens/menu_page.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:my_money_flow/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      User user = await ApiService().getUserByEmail(_emailController.text);
      if (user.parola == _passwordController.text) {
        // Save user data using UserProvider
        Provider.of<UserProvider>(context, listen: false).setUser(user);

        // Navigate to Menu Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MenuPage(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = "Email sau parola incorecta.";
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
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
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
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
