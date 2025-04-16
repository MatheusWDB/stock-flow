import 'package:frontend/models/enums/type_enum.dart';

class StockMovements {
  StockMovements({
    required this.stockMovementId,
    required this.date,
    required this.type,
    required this.quantity,
    required this.productId,
    required this.userId,
  });

  int stockMovementId;
  DateTime date;
  TypeEnum type;
  int quantity;
  int productId;
  int userId;
}
