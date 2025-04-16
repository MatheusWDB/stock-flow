import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/widgets/product_form_dialog.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  List<Product> products = [];

  TextEditingController nameOrCodeFilter = TextEditingController();
  String categoryFilter = 'All';
  Function(Product product) selector = (p) => p.code;
  bool ascending = true;

  @override
  Widget build(BuildContext context) {
    List<Product> renderProduct = products;
    renderProduct = filterProducts(renderProduct);
    renderProduct = sortProducts(renderProduct);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) => setState(() {}),
                      controller: nameOrCodeFilter,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        labelText: 'Pesquisar',
                        errorText: null,
                        focusedBorder: OutlineInputBorder(
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
                          child: const Text('Ordenar'),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() {
                            categoryFilter = 'All';
                          }),
                          child: const Text('Filtrar'),
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
              ElevatedButton.icon(
                onPressed: () => showFormProduct(null, null),
                label: const Icon(Icons.add),
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
      final int result = selector(a).compareTo(selector(b));
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
            product: product,
            index: index,
            getAllProducts: getAllProducts,
          );
        } else {
          return ProductFormDialog(
            getAllProducts: getAllProducts,
          );
        }
      },
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
}
