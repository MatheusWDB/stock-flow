// ignore_for_file: constant_identifier_names

enum TypeEnum {
  OUT('Saída'),
  IN('Entrada');

  final String displayName;

  // ignore: sort_constructors_first
  const TypeEnum(this.displayName);

  @override
  String toString() => name;
}
