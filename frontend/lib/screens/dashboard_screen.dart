import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/stock_movement_service.dart';
import 'package:frontend/widgets/movements_chart.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    getAllProducts();
    getAllStockMovements();
  }

  List<Product> products = [];
  List<StockMovement> movements = [];
  StockMovement? latestMovement;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: Text(
                    'Total de Produtos\n${products.length}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  child: Text(
                    'Estoque Baixo\n${products.where((product) => product.stockQuantity <= 5).length}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  child: Text(
                    'Última movimentação\n${latestMovement != null ? DateFormat("dd/MM/yyyy\nHH:mm").format(latestMovement!.date.toLocal()) : 'Nenhuma'}',
                    textAlign: TextAlign.center,
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
