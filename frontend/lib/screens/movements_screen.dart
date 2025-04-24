import 'package:flutter/material.dart';
import 'package:frontend/enums/type_enum.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/stock_movement_service.dart';
import 'package:frontend/widgets/main_menu.dart';
import 'package:frontend/widgets/movement_form_dialog.dart';
import 'package:intl/intl.dart';

class MovementsScreen extends StatefulWidget {
  const MovementsScreen({
    required this.user,
    required this.products,
    required this.movements,
    super.key,
  });

  final User user;
  final List<Product> products;
  final List<StockMovement> movements;
  @override
  State<MovementsScreen> createState() => _MovementsScreenState();
}

class _MovementsScreenState extends State<MovementsScreen> {
  @override
  void initState() {
    super.initState();
    user = widget.user;
    products = widget.products;
    movements = widget.movements;
  }

  late User user;
  List<Product> products = [];
  List<StockMovement> movements = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movements'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MainMenu(
                currentRoute: '/movements',
                user: user,
                products: products,
                movements: movements,
              ),
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(0.9),
                  1: FlexColumnWidth(0.8),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(0.9),
                },
                children: const [
                  TableRow(
                    children: [
                      Text(
                        'Produto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tipo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Qtd.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Responsável',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(0.9),
                      1: FlexColumnWidth(0.8),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1.2),
                      4: FlexColumnWidth(0.9),
                    },
                    children: movements
                        .map(
                          (m) => TableRow(children: [
                            Text(
                              products
                                  .firstWhere((p) => p.productId == m.productId)
                                  .name,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            Column(
                              children: [
                                Text(
                                  m.type.displayName,
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  m.type == TypeEnum.IN
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: m.type == TypeEnum.IN
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ],
                            ),
                            Text(
                              m.type == TypeEnum.IN
                                  ? '+${m.quantity}'
                                  : '-${m.quantity}',
                              style: TextStyle(
                                color: m.type == TypeEnum.IN
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              m.user!.name!,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              DateFormat('dd/MM/yy').format(m.date!.toLocal()),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                        )
                        .toList(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => showFormMovement(),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text('Registrar Movimentação'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showFormMovement() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MovementFormDialog(
          userId: user.userId!,
          products: products,
          getAllProductsAndMovements: getAllProductsAndMovements,
        );
      },
    );
  }

  void getAllProductsAndMovements() async {
    try {
      final resultProducts = await ProductService.getAllProducts();
      final resultMovements = await StockMovementService.getAllStockMovemente();
      setState(() {
        products = resultProducts;
        movements = resultMovements;
      });
    } catch (e) {
      debugPrint('Erro ao buscar produtos: $e');
    }
  }
}
