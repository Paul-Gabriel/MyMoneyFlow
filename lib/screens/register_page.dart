import 'package:flutter/material.dart';
import 'package:my_money_flow/services/api_service.dart';
import 'package:my_money_flow/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _numeController = TextEditingController();
  final TextEditingController _prenumeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _venitController = TextEditingController();
  final TextEditingController _necesitatiController = TextEditingController();
  final TextEditingController _dorinteController = TextEditingController();
  final TextEditingController _economiController = TextEditingController();

  String? _message;

  Future<void> _register() async {
    setState(() {
      _message = null; // Clear any previous errors
    });

    if (_numeController.text.isEmpty || _prenumeController.text.isEmpty || _venitController.text.isEmpty || _necesitatiController.text.isEmpty || 
        _dorinteController.text.isEmpty || _economiController.text.isEmpty ||_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _message = "Campurile nu pot fi goale.";
      });
      return;
    }else{
      ApiService().createUser(User(id: 0, nume: _numeController.text, prenume: _prenumeController.text, venit: int.parse(_venitController.text), procentNevoi: int.parse(_necesitatiController.text), procentDorinte: int.parse(_dorinteController.text), procentEconomi: int.parse(_economiController.text), email: _emailController.text, parola: _passwordController.text));
      // setState(() {
      //   _message = "User creat cu succes!";
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //Introducere nume
            TextField(
              controller: _numeController,
              decoration: const InputDecoration(
                labelText: 'Nume',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            
            //Introducere prenume
            TextField(
              controller: _prenumeController,
              decoration: const InputDecoration(
                labelText: 'Prenume',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            //Introducere venit
            TextField(
              controller: _venitController,
              decoration: const InputDecoration(
                labelText: 'Venit',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            //Introducere procent necesitati
            TextField(
              controller: _necesitatiController,
              decoration: const InputDecoration(
                labelText: 'Necesitati',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            //Introducere procent dorinte
            TextField(
              controller: _dorinteController,
              decoration: const InputDecoration(
                labelText: 'Dorinte',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            //Introducere procent economi
            TextField(
              controller: _economiController,
              decoration: const InputDecoration(
                labelText: 'Economi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            //Introducere email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            //Introducere parola
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
            if (_message != null) 
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _message!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_message == null) 
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'User creat cu succes!',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
