import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class ProductFormDialog extends StatefulWidget {
  const ProductFormDialog({
    required this.saveProduct,
    super.key,
    this.product,
    this.index,
  });
  
  final Product? product;
  final int? index;
  final Function(Map<String, dynamic>, int?) saveProduct;

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  late Product? product;
  late int? index;
  late Map<String, dynamic> controller;
  late Map<String, dynamic> error;
  late Function(Map<String, dynamic>, int?) saveProduct;

  @override
  void initState() {
    super.initState();
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
    saveProduct = widget.saveProduct;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => closeDialog(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final attributes = [
              'name',
              'code',
              'costPrice',
              'salePrice',
              'stockQuantity'
            ];

            for (var attribute in attributes) {
              if (controller[attribute]!.text.isEmpty) {
                setState(() {
                  error[attribute] = 'Campo requerido';
                });
                return;
              }
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

            saveProduct(controller, index);
            closeDialog();
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
}
