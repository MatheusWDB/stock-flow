import 'dart:convert';
import 'package:frontend/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = 'http://10.0.2.2:8080/products';

  static Future<void> createProduct(Product product, int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar produto');
    }
  }

  static Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar produtos: ${response.statusCode}');
    }
  }

  static Future<void> updateProduct(Product product, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao atualizar produto');
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar produto');
    }
  }
}
