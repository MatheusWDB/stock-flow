import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:frontend/enums/sort_enum.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/stock_movement_service.dart';
import 'package:frontend/widgets/generate_pdf.dart';
import 'package:frontend/widgets/main_menu.dart';
import 'package:frontend/widgets/product_form_dialog.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    required this.user,
    required this.products,
    required this.movements,
    super.key,
  });

  final User user;
  final List<Product> products;
  final List<StockMovement> movements;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
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

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  TextEditingController nameOrCodeFilter = TextEditingController();
  SortEnum sort = SortEnum.productName;
  String categoryFilter = 'All';
  bool ascending = true;

  @override
  Widget build(BuildContext context) {
    List<Product> renderProduct = products;
    renderProduct = filterProducts(renderProduct);
    renderProduct = sortProducts(renderProduct);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ProductList'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              MainMenu(
                currentRoute: '/products',
                user: user,
                products: products,
                movements: movements,
              ),
              Column(
                spacing: 8,
                children: [
                  TextField(
                    onChanged: (value) => setState(() {}),
                    controller: nameOrCodeFilter,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      labelText: 'Pesquisar',
                      errorText: null,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return SortEnum.values.map((value) {
                            return PopupMenuItem(
                              value: value,
                              child: Text(value.displayName),
                            );
                          }).toList();
                        },
                        onSelected: (value) => setState(() {
                          final SortEnum oldValue = sort;
                          sort = value;
                          oldValue == value
                              ? ascending = !ascending
                              : ascending = true;
                        }),
                        child: Row(
                          children: [
                            Text('Ordenar por: ${sort.displayName}'),
                            ascending
                                ? const Icon(Icons.arrow_upward)
                                : const Icon(Icons.arrow_downward),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) {
                          final Set<String> categories = <String>{};

                          final List<PopupMenuItem<String>> categoryItems = [
                            const PopupMenuItem(
                              value: 'All',
                              child: Text('Tudo'),
                            ),
                          ];

                          categoryItems.addAll(products
                              .expand((p) => p.categories)
                              .where((cat) => categories.add(cat.name))
                              .map(
                                (cat) => PopupMenuItem(
                                  value: cat.name,
                                  child: Text(cat.name[0].toUpperCase() +
                                      cat.name.substring(1)),
                                ),
                              )
                              .toList());

                          return categoryItems;
                        },
                        onSelected: (value) => setState(() {
                          categoryFilter = value;
                        }),
                        child: Text(
                            'Filtrar por: ${categoryFilter == 'All' ? 'Tudo' : categoryFilter[0].toUpperCase() + categoryFilter.substring(1)}'),
                      ),
                    ],
                  ),
                ],
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
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text('${renderProduct[index].description}'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text('Código: ${renderProduct[index].code}'),
                                Text(
                                    'Preço de Custo: ${currencyFormat.format(renderProduct[index].costPrice)}'),
                                Text(
                                    'Preço de Venda: ${currencyFormat.format(renderProduct[index].salePrice)}'),
                                Text(
                                  'Estoque: ${renderProduct[index].stockQuantity} unidades',
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Categorias:'),
                                    const SizedBox(
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
                                              ' ${renderProduct[index].categories[indexCategory].name}',
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
              ElevatedButton(
                onPressed: () => showFormProduct(null, null),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text('Adiciona Produto'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    GeneratePDF(products: products).generatePDFProduct(),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text('Gerar PDF'),
                  ],
                ),
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
      final int result = switch (sort) {
        SortEnum.productCode => a.code.compareTo(b.code),
        SortEnum.productName => a.name.compareTo(b.name),
        SortEnum.costPrice => a.costPrice.compareTo(b.costPrice),
        SortEnum.salePrice => a.salePrice.compareTo(b.salePrice),
        SortEnum.stockQuantity => a.stockQuantity.compareTo(b.stockQuantity),
      };
      return ascending ? result : -result;
    });
    return products;
  }

  List<Product> filterProducts(List<Product> products) {
    products = categoryFilter == 'All'
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
            userId: user.userId!,
            getAllProductsAndMovements: getAllProductsAndMovements,
            product: product,
            index: index,
          );
        } else {
          return ProductFormDialog(
            userId: user.userId!,
            getAllProductsAndMovements: getAllProductsAndMovements,
          );
        }
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
