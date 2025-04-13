import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  final List<Map<String, dynamic>> mockProducts = [
    {
      "name": "Camiseta Básica",
      "description": "Camiseta 100% algodão, ideal para o dia a dia.",
      "code": "PROD001",
      "costPrice": 20.00,
      "salePrice": 39.90,
      "stockQuantity": 150,
      "categories": [
        {"name": "Vestuário"},
        {"name": "Masculino"},
      ]
    },
    {
      "name": "Notebook Gamer X",
      "description": "Notebook com placa de vídeo dedicada, ideal para jogos.",
      "code": "PROD002",
      "costPrice": 4500.00,
      "salePrice": 5999.99,
      "stockQuantity": 10,
      "categories": [
        {"name": "Informática"},
        {"name": "Eletrônicos"},
      ]
    },
    {
      "name": "Fone Bluetooth",
      "description": "Fone de ouvido sem fio com cancelamento de ruído.",
      "code": "PROD003",
      "costPrice": 85.00,
      "salePrice": 149.90,
      "stockQuantity": 75,
      "categories": [
        {"name": "Áudio"},
        {"name": "Acessórios"},
      ]
    },
    {
      "name": "Cafeteira Elétrica",
      "description":
          "Cafeteira com capacidade de 1 litro e função programável.",
      "code": "PROD004",
      "costPrice": 120.00,
      "salePrice": 199.90,
      "stockQuantity": 30,
      "categories": [
        {"name": "Eletrodomésticos"},
        {"name": "Cozinha"},
      ]
    },
    {
      "name": "Tênis Esportivo",
      "description": "Tênis leve e confortável para corridas e caminhadas.",
      "code": "PROD005",
      "costPrice": 130.00,
      "salePrice": 259.90,
      "stockQuantity": 80,
      "categories": [
        {"name": "Calçados"},
        {"name": "Esportes"},
      ]
    },
    {
      "name": "Smartphone Z10",
      "description": "Celular com 128GB de armazenamento e câmera dupla.",
      "code": "PROD006",
      "costPrice": 1800.00,
      "salePrice": 2499.99,
      "stockQuantity": 45,
      "categories": [
        {"name": "Eletrônicos"},
        {"name": "Celulares"},
      ]
    },
    {
      "name": "Mochila Escolar",
      "description": "Mochila resistente com vários compartimentos.",
      "code": "PROD007",
      "costPrice": 40.00,
      "salePrice": 79.90,
      "stockQuantity": 5,
      "categories": [
        {"name": "Acessórios"},
        {"name": "Escolar"},
      ]
    },
    {
      "name": "Livro: O Poder do Hábito",
      "description": "Best-seller sobre hábitos e comportamento humano.",
      "code": "PROD008",
      "costPrice": 25.00,
      "salePrice": 49.90,
      "stockQuantity": 100,
      "categories": [
        {"name": "Livros"},
        {"name": "Desenvolvimento Pessoal"},
      ]
    },
    {
      "name": "Relógio de Pulso",
      "description": "Relógio analógico com pulseira de couro.",
      "code": "PROD009",
      "costPrice": 95.00,
      "salePrice": 179.90,
      "stockQuantity": 60,
      "categories": [
        {"name": "Moda"},
        {"name": "Acessórios"},
      ]
    },
    {
      "name": "Mesa Gamer",
      "description": "Mesa espaçosa com suporte para monitor e acessórios.",
      "code": "PROD010",
      "costPrice": 350.00,
      "salePrice": 599.90,
      "stockQuantity": 20,
      "categories": [
        {"name": "Móveis"},
        {"name": "Gaming"},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.002),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: mockProducts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        surfaceTintColor:
                            mockProducts[index]["stockQuantity"] <= 5
                                ? Colors.red
                                : Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(mockProducts[index]["name"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(mockProducts[index]["description"]),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Código: ${mockProducts[index]["code"]}"),
                              Text(
                                  "Preço de Custo: ${currencyFormat.format(mockProducts[index]["costPrice"])}"),
                              Text(
                                  "Preço de Venda: ${currencyFormat.format(mockProducts[index]["salePrice"])}"),
                              Text(
                                "Estoque: ${mockProducts[index]["stockQuantity"]} unidades",
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Categorias:"),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.705,
                                    height: 60,
                                    child: Container(
                                      color: Colors.white,
                                      child: ListView.builder(
                                        itemCount: mockProducts[index]
                                                ["categories"]
                                            .length,
                                        itemBuilder: (context, indexCategory) {
                                          return Text(
                                            " ${mockProducts[index]["categories"][indexCategory]["name"]}",
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
