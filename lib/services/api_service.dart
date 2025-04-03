import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/plata.dart';

class ApiService {
  final String baseUrl = 'http://192.168.0.120:8001'; // WiFi acasa
  // final String baseUrl = 'http://192.168.2.23:8001'; // Hotspot telefon

  // POST create user
  Future<void> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Eroare la crearea user-ului');
    }
  }

  // GET user by email
  Future<User> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/users/email/$email'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Userul nu există');
    } else {
      throw Exception('Eroare la încărcarea utilizatorului');
    }
  }

  // PUT update user
  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Eroare la actualizarea user-ului');
    }
  }

  // DELETE user
  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode != 200) {
      throw Exception('Eroare la ștergerea user-ului');
    }
  }

  // POST create plata
  Future<void> createPlata(Plata plata) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(plata.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Eroare la crearea plății');
    }
  }

  // GET plati by user
  Future<List<Plata>> getPlatiByUser(String userRef) async {
    final response = await http.get(Uri.parse('$baseUrl/payments/$userRef'));

    if (response.statusCode == 200) {
      List<Plata> plati = [];
      List<dynamic> jsonList = json.decode(response.body);
      for (int i = 0; i < jsonList.length; i++) {
        plati.add(Plata.fromJson(jsonList[i]));
      }
      return plati;
    } else {
      throw Exception('Eroare la încărcarea plăților');
    }
  }

  // PUT update plata
  void updatePlata(Plata plata) async {
    final response = await http.put(
      Uri.parse('$baseUrl/payments/${plata.id}'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(plata.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Eroare la actualizarea plății');
    }
  }

  // DELETE plata
  Future<void> deletePlata(String plataId) async {
    final response = await http.delete(Uri.parse('$baseUrl/payments/$plataId'));

    if (response.statusCode != 200) {
      throw Exception('Eroare la ștergerea plății');
    }
  }
}
