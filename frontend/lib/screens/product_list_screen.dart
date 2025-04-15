import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/widgets/product_form_dialog.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  final List<Product> mockProducts = [
    Product(
      name: "Camiseta Básica",
      description: "Camiseta 100% algodão, ideal para o dia a dia.",
      code: "PROD001",
      costPrice: 20.00,
      salePrice: 39.90,
      stockQuantity: 150,
      categories: [
        Category(name: "Vestuário"),
        Category(name: "Masculino"),
      ],
    ),
    Product(
      name: "Notebook Gamer X",
      description: "Notebook com placa de vídeo dedicada, ideal para jogos.",
      code: "PROD002",
      costPrice: 4500.00,
      salePrice: 5999.99,
      stockQuantity: 10,
      categories: [
        Category(name: "Informática"),
        Category(name: "Eletrônicos"),
      ],
    ),
    Product(
      name: "Fone Bluetooth",
      description: "Fone de ouvido sem fio com cancelamento de ruído.",
      code: "PROD003",
      costPrice: 85.00,
      salePrice: 149.90,
      stockQuantity: 75,
      categories: [
        Category(name: "Áudio"),
        Category(name: "Acessórios"),
      ],
    ),
    Product(
      name: "Cafeteira Elétrica",
      description: "Cafeteira com capacidade de 1 litro e função programável.",
      code: "PROD004",
      costPrice: 120.00,
      salePrice: 199.90,
      stockQuantity: 30,
      categories: [
        Category(name: "Eletrodomésticos"),
        Category(name: "Cozinha"),
      ],
    ),
    Product(
      name: "Tênis Esportivo",
      description: "Tênis leve e confortável para corridas e caminhadas.",
      code: "PROD005",
      costPrice: 130.00,
      salePrice: 259.90,
      stockQuantity: 80,
      categories: [
        Category(name: "Calçados"),
        Category(name: "Esportes"),
      ],
    ),
    Product(
      name: "Smartphone Z10",
      description: "Celular com 128GB de armazenamento e câmera dupla.",
      code: "PROD006",
      costPrice: 1800.00,
      salePrice: 2499.99,
      stockQuantity: 45,
      categories: [
        Category(name: "Eletrônicos"),
        Category(name: "Celulares"),
      ],
    ),
    Product(
      name: "Mochila Escolar",
      description: "Mochila resistente com vários compartimentos.",
      code: "PROD007",
      costPrice: 40.00,
      salePrice: 79.90,
      stockQuantity: 5,
      categories: [
        Category(name: "Acessórios"),
        Category(name: "Escolar"),
      ],
    ),
    Product(
      name: "Livro: O Poder do Hábito",
      description: "Best-seller sobre hábitos e comportamento humano.",
      code: "PROD008",
      costPrice: 25.00,
      salePrice: 49.90,
      stockQuantity: 100,
      categories: [
        Category(name: "Livros"),
        Category(name: "Desenvolvimento Pessoal"),
      ],
    ),
    Product(
      name: "Relógio de Pulso",
      description: "Relógio analógico com pulseira de couro.",
      code: "PROD009",
      costPrice: 95.00,
      salePrice: 179.90,
      stockQuantity: 60,
      categories: [
        Category(name: "Moda"),
        Category(name: "Acessórios"),
      ],
    ),
    Product(
      name: "Mesa Gamer",
      description: "Mesa espaçosa com suporte para monitor e acessórios.",
      code: "PROD010",
      costPrice: 350.00,
      salePrice: 599.90,
      stockQuantity: 20,
      categories: [
        Category(name: "Móveis"),
        Category(name: "Gaming"),
      ],
    ),
  ];

  TextEditingController nameOrCodeFilter = TextEditingController();
  String categoryFilter = "All";
  Function(Product product) selector = (p) => p.code;
  bool ascending = true;

  @override
  Widget build(BuildContext context) {
    List<Product> renderProduct = mockProducts;
    renderProduct = filterProducts(renderProduct);
    renderProduct = sortProducts(renderProduct);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) => setState(() {}),
                      controller: nameOrCodeFilter,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        labelText: "Pesquisar",
                        errorText: null,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => setState(() {
                            selector = (p) => p.name;
                            ascending = !ascending;
                          }),
                          child: Text("Ordenar"),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() {
                            categoryFilter = "All";
                          }),
                          child: Text("Filtrar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: renderProduct.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
                          surfaceTintColor:
                              renderProduct[index].stockQuantity <= 5
                                  ? Colors.red
                                  : Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Center(
                                  child: Text(
                                    renderProduct[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text("${renderProduct[index].description}"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Código: ${renderProduct[index].code}"),
                                Text(
                                    "Preço de Custo: ${currencyFormat.format(renderProduct[index].costPrice)}"),
                                Text(
                                    "Preço de Venda: ${currencyFormat.format(renderProduct[index].salePrice)}"),
                                Text(
                                  "Estoque: ${renderProduct[index].stockQuantity} unidades",
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
                                          0.6,
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: ListView.builder(
                                          itemCount: renderProduct[index]
                                              .categories
                                              .length,
                                          itemBuilder:
                                              (context, indexCategory) {
                                            return Text(
                                              " ${renderProduct[index].categories[indexCategory].name}",
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
                        ),
                        onTap: () =>
                            showFormProduct(renderProduct[index], index),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => showFormProduct(null, null),
                label: Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }

  String normalize(String input) => removeDiacritics(input).toUpperCase();

  List<Product> sortProducts(List<Product> products) {
    products.sort((a, b) {
      int result = selector(a).compareTo(selector(b));
      return ascending ? result : -result;
    });
    return products;
  }

  List<Product> filterProducts(List<Product> products) {
    products = categoryFilter == "All"
        ? products
        : products
            .where((product) => product.categories
                .map((cat) => cat.name)
                .contains(categoryFilter))
            .toList();

    return nameOrCodeFilter.text.isNotEmpty
        ? products
            .where((product) =>
                normalize(product.name)
                    .contains(normalize(nameOrCodeFilter.text)) ||
                normalize(product.code)
                    .contains(normalize(nameOrCodeFilter.text)))
            .toList()
        : products;
  }

  void showFormProduct(Product? product, int? index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        if (product != null && index != null) {
          return ProductFormDialog(
            product: product,
            index: index,
            saveProduct: saveProduct,
          );
        } else {
          return ProductFormDialog(
            saveProduct: saveProduct,
          );
        }
      },
    );
  }

  void saveProduct(Map<String, dynamic> controller, int? index) {
    List<Category> categories = [];

    for (TextEditingController category in controller["categories"]) {
      categories.add(Category(name: category.text));
    }

    Product newProduct = Product(
      name: controller["name"].text,
      description: controller["description"].text,
      code: controller["code"].text,
      costPrice: double.tryParse(controller["costPrice"].text) ?? 0,
      salePrice: double.tryParse(controller["salePrice"].text) ?? 0,
      stockQuantity: int.tryParse(controller["stockQuantity"].text) ?? 0,
      categories: categories,
    );

    setState(() {
      if (index == null) {
        mockProducts.add(newProduct);
      } else {
        mockProducts[index] = newProduct;
      }
    });
  }
}
