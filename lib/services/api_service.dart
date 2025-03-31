import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/plata.dart';

class ApiService {
  final String baseUrl = 'http://192.168.0.120:8001';

  // POST create user
  void createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
        },
      body: json.encode(user.toJson()),
    );
    if (response.statusCode != 200) {
      // print('Failed to create user. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
      throw Exception('Eroare la crearea user-ului');
    }
  }

  // GET user by email
  Future<User> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/users/email/$email'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404){
      throw Exception('Userul nu există');
    } else {
      throw Exception('Eroare la încărcarea utilizatorului');
    }
  }

  // PUT update user
  void updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      // print('Failed to update user. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
      throw Exception('Eroare la actualizarea user-ului');
    }
  }

  // DELETE user
  void deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode != 200) {
      // print('Failed to delete user. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
      throw Exception('Eroare la ștergerea user-ului');
    }
  }

  // POST create plata
  void createPlata(Plata plata) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(plata.toJson()),
    );
    if (response.statusCode != 200) {
      // print('Failed to create plata. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
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
      // return jsonList; //.map((json) => Plata.fromJson(json)).toList();
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
      // print('Failed to update plata. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
      throw Exception('Eroare la actualizarea plății');
    }
  }

  // DELETE plata
  void deletePlata(String plataId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/payments/$plataId'));

    if (response.statusCode != 200) {
      // print('Failed to delete plata. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
      throw Exception('Eroare la ștergerea plății');
    }
  }
}
