import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/stock_movement_service.dart';
import 'package:frontend/widgets/main_menu.dart';
import 'package:frontend/widgets/movements_chart.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({required this.user, super.key});
  final User user;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    getAllProducts();
    getAllStockMovements();
    user = widget.user;
  }

  late User user;
  List<Product> products = [];
  List<StockMovement> movements = [];
  StockMovement? latestMovement;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainMenu(
                currentRoute: '/dashboard',
                user: user,
                products: products,
                movements: movements,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Total de Produtos\n${products.length}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Estoque Baixo\n${products.where((product) => product.stockQuantity <= 5).length}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Última movimentação\n${latestMovement != null ? DateFormat("dd/MM/yyyy - HH:mm").format(latestMovement!.date.toLocal()) : 'Nenhuma'}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (movements.isNotEmpty)
              MovementsChart(
                movements: movements,
              ),
          ],
        ),
      ),
    );
  }

  void getAllProducts() async {
    try {
      final result = await ProductService.getAllProducts();
      setState(() {
        products = result;
      });
    } catch (e) {
      debugPrint('Erro ao buscar produtos: $e');
    }
  }

  void getAllStockMovements() async {
    try {
      final result = await StockMovementService.getAllStockMovemente();
      setState(() {
        movements = result;
        latestMovement =
            movements.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
      });
    } catch (e) {
      debugPrint('Erro ao buscar os registros de movimentação: $e');
    }
  }
}
