import 'dart:convert';

import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://10.0.2.2:8080/users';

  static Future<void> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar usuário: ${response.statusCode}');
    }
  }

  static Future<void> login(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final loggedUser = User.fromJson(data);
      User.currentUser = loggedUser;
    } else {
      throw Exception('Erro ao buscar usuário: ${response.statusCode}');
    }
  }
}
