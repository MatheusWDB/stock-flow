import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/services/product_service.dart';

class ProductFormDialog extends StatefulWidget {
  const ProductFormDialog({
    required this.getAllProductsAndMovements,
    required this.userId,
    super.key,
    this.product,
    this.index,
  });

  final int userId;
  final Function() getAllProductsAndMovements;
  final Product? product;
  final int? index;

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    getAllProductsAndMovements = widget.getAllProductsAndMovements;
    product = widget.product;
    index = widget.index;
    controller = {
      'name': TextEditingController(text: product?.name),
      'description': TextEditingController(text: product?.description),
      'code': TextEditingController(text: product?.code),
      'costPrice': TextEditingController(text: product?.costPrice.toString()),
      'salePrice': TextEditingController(text: product?.salePrice.toString()),
      'stockQuantity':
          TextEditingController(text: product?.stockQuantity.toString()),
      'categories': product != null
          ? product!.categories
              .map((category) => TextEditingController(text: category.name))
              .toList()
          : [TextEditingController()],
    };
    error = {
      'name': null,
      'description': null,
      'code': null,
      'costPrice': null,
      'salePrice': null,
      'stockQuantity': null,
      'categories': product != null
          ? List.generate(product!.categories.length, (value) => null)
          : [null],
    };
  }

  late int userId;
  late Function() getAllProductsAndMovements;
  late Product? product;
  late int? index;
  late Map<String, dynamic> controller;
  late Map<String, dynamic> error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        if (product != null)
          TextButton(
              onPressed: () {
                deleteProduct();
              },
              child: const Text('Deletar')),
        TextButton(
          onPressed: () => closeDialog(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final List<String> attributes = [
              'name',
              'code',
              'costPrice',
              'salePrice',
              'stockQuantity'
            ];

            for (String attribute in attributes) {
              if (controller[attribute]!.text.isEmpty) {
                setState(() {
                  error[attribute] = 'Campo requerido';
                });
                return;
              }
            }

            if (double.tryParse(controller['costPrice'].text)! >=
                double.tryParse(controller['salePrice'].text)!) {
              setState(() {
                error['costPrice'] =
                    'O preço de custo deve ser menor que o de venda';

                error['salePrice'] =
                    'O preço de venda deve ser maior que o de custo';
              });
              return;
            }

            bool hasCategoryError = false;
            for (int i = 0; i < controller['categories'].length; i++) {
              if (controller['categories'][i].text.isEmpty) {
                setState(() {
                  error['categories'][i] = 'Campo requerido';
                });
                hasCategoryError = true;
              }
              if (hasCategoryError) return;
            }

            if (hasCategoryError) return;

            saveProduct();
          },
          child: const Text('Salvar'),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: controller['name'],
              decoration: InputDecoration(
                errorText: error['name'],
                labelText: 'Nome',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  error['name'] = null;
                });
              },
            ),
            TextField(
              controller: controller['description'],
              decoration: InputDecoration(
                errorText: error['description'],
                labelText: 'Descrição',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  error['description'] = null;
                });
              },
            ),
            TextField(
              controller: controller['code'],
              decoration: InputDecoration(
                errorText: error['code'],
                labelText: 'Código',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  error['code'] = null;
                });
              },
            ),
            TextField(
              controller: controller['costPrice'],
              decoration: InputDecoration(
                errorText: error['costPrice'],
                labelText: 'Preço de Custo',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  error['costPrice'] = null;
                });
              },
            ),
            TextField(
              controller: controller['salePrice'],
              decoration: InputDecoration(
                errorText: error['salePrice'],
                labelText: 'Preço de Venda',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  error['salePrice'] = null;
                });
              },
            ),
            TextField(
              controller: controller['stockQuantity'],
              decoration: InputDecoration(
                errorText: error['stockQuantity'],
                labelText: 'Quantidade em Estoque',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  error['stockQuantity'] = null;
                });
              },
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categorias:',
                textAlign: TextAlign.start,
                style: TextStyle(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(controller['categories'].length, (index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller['categories'][index],
                              decoration: InputDecoration(
                                errorText: error['categories'][index],
                                labelText: 'Categoria ${index + 1}',
                                suffixIcon: index == 0
                                    ? null
                                    : IconButton(
                                        icon: const Icon(Icons.remove_circle,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            controller['categories']
                                                .removeAt(index);
                                          });
                                        },
                                      ),
                              ),
                              onChanged: (value) {
                                error['categories'][index] = null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      );
                    }),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            controller['categories']
                                .add(TextEditingController());
                            error['categories'].add(null);
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar categoria'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void closeDialog() {
    Navigator.of(context).pop();
    resetController();
    resetError();
  }

  void resetController() {
    controller['name'].clear();
    controller['description'].clear();
    controller['code'].clear();
    controller['costPrice'].clear();
    controller['salePrice'].clear();
    controller['stockQuantity'].clear();
    controller['categories'].clear();
  }

  void resetError() {
    error['name'] = null;
    error['description'] = null;
    error['code'] = null;
    error['costPrice'] = null;
    error['salePrice'] = null;
    error['stockQuantity'] = null;
    error['categories'].clear();
  }

  void saveProduct() async {
    final List<Category> categories = [];

    for (TextEditingController category in controller['categories']) {
      categories.add(Category(name: category.text));
    }

    final Product newProduct = Product(
      productId: product?.productId,
      name: controller['name'].text,
      description: controller['description'].text,
      code: controller['code'].text,
      costPrice: double.tryParse(controller['costPrice'].text) ?? 0,
      salePrice: double.tryParse(controller['salePrice'].text) ?? 0,
      stockQuantity: int.tryParse(controller['stockQuantity'].text) ?? 0,
      categories: categories,
    );

    try {
      if (newProduct.productId == null) {
        await ProductService.createProduct(newProduct, userId);
      } else {
        await ProductService.updateProduct(newProduct, newProduct.productId!);
      }

      getAllProductsAndMovements();
      closeDialog();
    } catch (e) {
      debugPrint('Erro ao salvar produto: $e');
    }
  }

  void deleteProduct() async {
    try {
      await ProductService.deleteProduct(product!.productId!);

      getAllProductsAndMovements();
      closeDialog();
    } catch (e) {
      debugPrint('Erro ao salvar produto: $e');
    }
  }
}
