import 'package:frontend/models/category.dart';

class Product {
  Product({
    required this.name,
    required this.code,
    required this.costPrice,
    required this.salePrice,
    required this.stockQuantity,
    required this.categories,
    this.description,
  });
  
  final String name;
  final String? description;
  final String code;
  final double costPrice;
  final double salePrice;
  final int stockQuantity;
  final List<Category> categories;
}
