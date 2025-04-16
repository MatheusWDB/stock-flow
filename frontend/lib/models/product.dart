import 'package:frontend/models/category.dart';

class Product {
  Product({
    required this.name,
    required this.code,
    required this.costPrice,
    required this.salePrice,
    required this.stockQuantity,
    required this.categories,
    this.productId,
    this.description,
  });

  final int? productId;
  final String name;
  final String? description;
  final String code;
  final double costPrice;
  final double salePrice;
  final int stockQuantity;
  final List<Category> categories;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
      costPrice: (json['costPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      stockQuantity: json['stockQuantity'],
      categories: (json['categories'] as List<dynamic>)
          .map((cat) => Category.fromJson(cat))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'description': description,
        'code': code,
        'costPrice': costPrice,
        'salePrice': salePrice,
        'stockQuantity': stockQuantity,
        'categories': categories.map((cat) => cat.toJson()).toList(),
      };
}
