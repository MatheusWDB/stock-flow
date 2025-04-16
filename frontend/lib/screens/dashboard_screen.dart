import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:graphic/graphic.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Product> mockProducts = [
    Product(
      productId: 1,
      name: 'Camiseta Básica',
      description: 'Camiseta 100% algodão, ideal para o dia a dia.',
      code: 'PROD001',
      costPrice: 20.00,
      salePrice: 39.90,
      stockQuantity: 150,
      categories: [
        Category(categoryId: 1, name: 'Vestuário'),
        Category(categoryId: 2, name: 'Masculino'),
      ],
    ),
    Product(
      productId: 2,
      name: 'Notebook Gamer X',
      description: 'Notebook com placa de vídeo dedicada, ideal para jogos.',
      code: 'PROD002',
      costPrice: 4500.00,
      salePrice: 5999.99,
      stockQuantity: 10,
      categories: [
        Category(categoryId: 3, name: 'Informática'),
        Category(categoryId: 4, name: 'Eletrônicos'),
      ],
    ),
    Product(
      productId: 3,
      name: 'Fone Bluetooth',
      description: 'Fone de ouvido sem fio com cancelamento de ruído.',
      code: 'PROD003',
      costPrice: 85.00,
      salePrice: 149.90,
      stockQuantity: 75,
      categories: [
        Category(categoryId: 5, name: 'Áudio'),
        Category(categoryId: 6, name: 'Acessórios'),
      ],
    ),
    Product(
      productId: 4,
      name: 'Cafeteira Elétrica',
      description: 'Cafeteira com capacidade de 1 litro e função programável.',
      code: 'PROD004',
      costPrice: 120.00,
      salePrice: 199.90,
      stockQuantity: 30,
      categories: [
        Category(categoryId: 7, name: 'Eletrodomésticos'),
        Category(categoryId: 8, name: 'Cozinha'),
      ],
    ),
    Product(
      productId: 5,
      name: 'Tênis Esportivo',
      description: 'Tênis leve e confortável para corridas e caminhadas.',
      code: 'PROD005',
      costPrice: 130.00,
      salePrice: 259.90,
      stockQuantity: 80,
      categories: [
        Category(categoryId: 9, name: 'Calçados'),
        Category(categoryId: 10, name: 'Esportes'),
      ],
    ),
    Product(
      productId: 6,
      name: 'Smartphone Z10',
      description: 'Celular com 128GB de armazenamento e câmera dupla.',
      code: 'PROD006',
      costPrice: 1800.00,
      salePrice: 2499.99,
      stockQuantity: 45,
      categories: [
        Category(categoryId: 4, name: 'Eletrônicos'),
        Category(categoryId: 11, name: 'Celulares'),
      ],
    ),
    Product(
      productId: 7,
      name: 'Mochila Escolar',
      description: 'Mochila resistente com vários compartimentos.',
      code: 'PROD007',
      costPrice: 40.00,
      salePrice: 79.90,
      stockQuantity: 5,
      categories: [
        Category(categoryId: 6, name: 'Acessórios'),
        Category(categoryId: 12, name: 'Escolar'),
      ],
    ),
    Product(
      productId: 8,
      name: 'Livro: O Poder do Hábito',
      description: 'Best-seller sobre hábitos e comportamento humano.',
      code: 'PROD008',
      costPrice: 25.00,
      salePrice: 49.90,
      stockQuantity: 100,
      categories: [
        Category(categoryId: 13, name: 'Livros'),
        Category(categoryId: 14, name: 'Desenvolvimento Pessoal'),
      ],
    ),
    Product(
      productId: 9,
      name: 'Relógio de Pulso',
      description: 'Relógio analógico com pulseira de couro.',
      code: 'PROD009',
      costPrice: 95.00,
      salePrice: 179.90,
      stockQuantity: 60,
      categories: [
        Category(categoryId: 15, name: 'Moda'),
        Category(categoryId: 6, name: 'Acessórios'),
      ],
    ),
    Product(
      productId: 10,
      name: 'Mesa Gamer',
      description: 'Mesa espaçosa com suporte para monitor e acessórios.',
      code: 'PROD010',
      costPrice: 350.00,
      salePrice: 599.90,
      stockQuantity: 20,
      categories: [
        Category(categoryId: 16, name: 'Móveis'),
        Category(categoryId: 17, name: 'Gaming'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Card(
                  child: Text(
                    'Total de Produtos\n${mockProducts.length}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  child: Text(
                    'Estoque Baixo\n${mockProducts.where((product) => product.stockQuantity <= 5).length}',
                    textAlign: TextAlign.center,
                  ),
                ),
                const Card(
                  child: Text(
                    'Última movimentação\n',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Chart(
                data: const [
                  {'genre': 'Sports', 'sold': 275},
                  {'genre': 'Strategy', 'sold': 115},
                  {'genre': 'Action', 'sold': 120},
                  {'genre': 'Shooter', 'sold': 350},
                  {'genre': 'Other', 'sold': 150},
                ],
                variables: {
                  'genre': Variable(
                    accessor: (Map map) => map['genre'] as String,
                  ),
                  'sold': Variable(
                    accessor: (Map map) => map['sold'] as num,
                  ),
                },
                marks: [IntervalMark()],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
