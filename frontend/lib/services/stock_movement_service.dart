import 'dart:convert';

import 'package:frontend/models/stock_movement.dart';
import 'package:http/http.dart' as http;

class StockMovementService {
  static const String baseUrl = 'http://10.0.2.2:8080/stock-movements';

  static Future<void> createStockMovement(StockMovement movement, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(movement.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao registrar movimentação: ${response.statusCode}');
    }
  }

  static Future<List<StockMovement>> getAllStockMovemente() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => StockMovement.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar movimentação: ${response.statusCode}');
    }
  }
}
