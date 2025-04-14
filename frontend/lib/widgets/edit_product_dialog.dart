import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class EditProductDialog extends StatefulWidget {
  final Product product;
  final Function(Map<String, dynamic>) editProduct;

  const EditProductDialog({
    super.key,
    required this.product,
    required this.editProduct,
  });

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  @override
  void initState() {
    super.initState();
    editProduct = widget.editProduct;
    product = widget.product;

    controller = {
      "name": TextEditingController(text: product.name),
      "description": TextEditingController(text: product.description),
      "code": TextEditingController(text: product.code),
      "costPrice": TextEditingController(text: product.costPrice.toString()),
      "salePrice": TextEditingController(text: product.salePrice.toString()),
      "stockQuantity":
          TextEditingController(text: product.stockQuantity.toString()),
      "categories": product.categories
          .map((category) => TextEditingController(text: category.name))
          .toList(),
    };

    error = {
      "name": null,
      "description": null,
      "code": null,
      "costPrice": null,
      "salePrice": null,
      "stockQuantity": null,
      "categories": List.generate(product.categories.length, (_) => null),
    };
  }

  late Function(Map<String, dynamic>) editProduct;
  late Product product;

  late Map<String, dynamic> controller;

  late Map<String, dynamic> error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [],
      content: Column(
        children: [
          TextField(
            controller: controller["name"],
            decoration: InputDecoration(
              errorText: error["name"],
              labelText: "Nome",
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            controller: controller["description"],
            decoration: InputDecoration(
              errorText: error["description"],
              labelText: "Descrição",
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            controller: controller["code"],
            decoration: InputDecoration(
              errorText: error["code"],
              labelText: "Código",
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            controller: controller["costPrice"],
            decoration: InputDecoration(
              errorText: error["costPrice"],
              labelText: "Preço de Custo",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            controller: controller["salePrice"],
            decoration: InputDecoration(
              errorText: error["salePrice"],
              labelText: "Preço de Venda",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            controller: controller["stockQuantity"],
            decoration: InputDecoration(
              errorText: error["stockQuantity"],
              labelText: "Quantidade em Estoque",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {});
            },
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categorias:",
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(controller["categories"].length, (index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller["categories"][index],
                            decoration: InputDecoration(
                              errorText: error["categories"][index],
                              labelText: 'Categoria ${index + 1}',
                              suffixIcon: index == 0
                                  ? null
                                  : IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          controller["categories"]
                                              .removeAt(index);
                                        });
                                      },
                                    ),
                            ),
                            onChanged: (value) {
                              error["categories"][index] = null;
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
                          controller["categories"].add(TextEditingController());
                          error["categories"].add(null);
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Adicionar categoria"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
