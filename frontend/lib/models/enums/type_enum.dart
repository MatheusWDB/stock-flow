// ignore_for_file: constant_identifier_names

enum TypeEnum {
  OUT('Saída', 0),
  IN('Entrada', 1);

  final String displayName;
  final int code;

  const TypeEnum(this.displayName, this.code);

  static TypeEnum fromCode(int code) {
    return TypeEnum.values.firstWhere(
      (e) => e.code == code,
      orElse: () => throw ArgumentError('Código inválido: $code'),
    );
  }

  static TypeEnum fromString(String name) {
    return TypeEnum.values.firstWhere(
      (e) => e.name == name.toUpperCase(),
      orElse: () => throw ArgumentError('Tipo inválido: $name'),
    );
  }

  @override
  String toString() => name;
}
