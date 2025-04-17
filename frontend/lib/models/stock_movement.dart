import 'package:frontend/models/enums/type_enum.dart';
import 'package:frontend/models/user.dart';

class StockMovement {
  StockMovement({
    required this.stockMovementId,
    required this.date,
    required this.type,
    required this.quantity,
    required this.productId,
    required this.user,
  });

  int stockMovementId;
  DateTime date;
  TypeEnum type;
  int quantity;
  int productId;
  User user;

  factory StockMovement.fromJson(Map<String, dynamic> json) {
    return StockMovement(
      stockMovementId: json['stockMovementId'],
      date: DateTime.parse(json['date']),
      type: TypeEnum.values[json['type']],
      quantity: json['quantity'],
      productId: json['productId'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'quantity': quantity,
        'productId': productId,
        'user': user.toJson(),
      };
}
