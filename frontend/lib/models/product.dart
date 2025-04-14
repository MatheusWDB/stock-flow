import 'package:frontend/models/category.dart';

class Product {
  final String name;
  final String? description;
  final String code;
  final double costPrice;
  final double salePrice;
  final int stockQuantity;
  final List<Category> categories;

  Product({
    required this.name,
    this.description,
    required this.code,
    required this.costPrice,
    required this.salePrice,
    required this.stockQuantity,
    required this.categories,
  });
}
