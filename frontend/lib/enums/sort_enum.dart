enum SortEnum {
  productCode('Código', 0),
  productName('Nome', 1),
  costPrice('Preço de Custo', 2),
  salePrice('Preço de Venda', 3),
  stockQuantity('Quantidade', 4);

  final String displayName;
  final int code;

  const SortEnum(this.displayName, this.code);

  static SortEnum fromCode(int code) {
    return SortEnum.values.firstWhere(
      (e) => e.code == code,
      orElse: () => throw ArgumentError('Código inválido: $code'),
    );
  }

  static SortEnum fromString(String name) {
    return SortEnum.values.firstWhere(
      (e) => e.name.toUpperCase() == name.toUpperCase(),
      orElse: () => throw ArgumentError('Ordenação inválida: $name'),
    );
  }

  @override
  String toString() => name;
}
