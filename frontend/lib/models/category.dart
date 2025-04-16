class Category {
  Category({
    required this.name,
    this.categoryId,
  });

  final int? categoryId;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
