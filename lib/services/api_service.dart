import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/plata.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // // GET all users
  // Future<List<User>> getUsers() async {
  //   final response = await http.get(Uri.parse('$baseUrl/users/'));
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonList = json.decode(response.body);
  //     return jsonList.map((json) => User.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Eroare la încărcarea utilizatorilor');
  //   }
  // }

  // // GET user by id
  // Future<User> getUserById(int id) async {
  //   final response = await http.get(Uri.parse('$baseUrl/users/$id'));
  //   if (response.statusCode == 200) {
  //     return User.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Eroare la încărcarea utilizatorului');
  //   }
  // }

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
      print('Failed to create user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Eroare la crearea user-ului');
    }
  }

  Future<User> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/users/email/$email'));//http://127.0.0.1:8000/users/email/paul%40email.com
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404){
      throw Exception('Userul nu există');
    } else {
      throw Exception('Eroare la încărcarea utilizatorului');
    }
  }

  // Similar pentru plăți
  Future<List> getPlatiByUser(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/plati/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList; //.map((json) => Plata.fromJson(json)).toList();
    } else {
      throw Exception('Eroare la încărcarea plăților');
    }
  }

  void createPlata(Plata plata) async {
    final response = await http.post(
      Uri.parse('$baseUrl/plata/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(plata.toJson()),
    );
    if (response.statusCode != 200) {
      print('Failed to create plata. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Eroare la crearea plății');
    }
  }

  void updatePlata(Plata plata) async {
    final response = await http.put(
      Uri.parse('$baseUrl/plata/${plata.id}?user_id=${plata.userId}'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode(plata.toJson()),
    );

    if (response.statusCode != 200) {
      print('Failed to update plata. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Eroare la actualizarea plății');
    }
  }

  void deletePlata(int id, int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/plata/$id?user_id=$userId'));//http://127.0.0.1:8000/plata/3?user_id=0

    if (response.statusCode != 200) {
      print('Failed to delete plata. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Eroare la ștergerea plății');
    }
  }
}
