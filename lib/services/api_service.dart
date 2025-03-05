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

  // // POST create user
  // Future<User> createUser(User user) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/users/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(user.toJson()),
  //   );
  //   if (response.statusCode == 201) {
  //     return User.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Eroare la crearea utilizatorului');
  //   }
  // }

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
      body: json.encode({
        'id': 0,
        'user_id': 0,
        'suma': 150,
        'categorie': 'nevoi',
        'descriere': 'combustibil',
        'data': '2025-03-05T12:38:49.340Z'
      }),
    );

    if (response.statusCode != 200) {
      print('Failed to create plata. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Eroare la crearea plății');
    }
  }
}
