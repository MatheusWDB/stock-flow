import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens/dashboard_screen.dart';
import 'package:frontend/screens/movements_screen.dart';
import 'package:frontend/screens/product_list_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    required this.currentRoute,
    required this.user,
    required this.products,
    required this.movements,
    super.key,
  });

  final String currentRoute;
  final User user;
  final List<Product> products;
  final List<StockMovement> movements;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(user: user),
                  ),
                );
              },
              child: Text(
                'Início',
                style: style('/dashboard'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(
                      user: user,
                      products: products,
                      movements: movements,
                    ),
                  ),
                );
              },
              child: Text(
                'Produtos',
                style: style('/products'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovementsScreen(
                      user: user,
                      products: products,
                      movements: movements,
                    ),
                  ),
                );
              },
              child: Text(
                'Movimentações',
                style: style('/movements'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Relatórios',
                style: style('/reports'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  TextStyle style(String route) {
    return TextStyle(
      color: currentRoute == route
          ? const Color(0xFF551A8B)
          : const Color(0xFF0000EE),
      fontWeight: currentRoute == route ? FontWeight.bold : FontWeight.normal,
    );
  }
}
