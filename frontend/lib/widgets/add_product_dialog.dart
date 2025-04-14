import 'package:flutter/material.dart';

class AddProductDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) addProduct;

  const AddProductDialog({
    super.key,
    required this.addProduct,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  @override
  void initState() {
    super.initState();
    addProduct = widget.addProduct;
  }

  late Function(Map<String, dynamic>) addProduct;

  Map<String, dynamic> controller = {
    "name": TextEditingController(),
    "description": TextEditingController(),
    "code": TextEditingController(),
    "costPrice": TextEditingController(),
    "salePrice": TextEditingController(),
    "stockQuantity": TextEditingController(),
    "categories": [TextEditingController()],
  };

  late final Map<String, dynamic> error = {
    "name": null,
    "description": null,
    "code": null,
    "costPrice": null,
    "salePrice": null,
    "stockQuantity": null,
    "categories": [null],
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => closeDialog(),
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (controller["name"].text.isEmpty) {
                error["name"] = "Campo requerido";
                return;
              }
              if (controller["code"].text.isEmpty) {
                error["code"] = "Campo requerido";
                return;
              }
              if (controller["costPrice"].text.isEmpty) {
                error["costPrice"] = "Campo requerido";
                return;
              }
              if (controller["salePrice"].text.isEmpty) {
                error["salePrice"] = "Campo requerido";
                return;
              }
              if (controller["stockQuantity"].text.isEmpty) {
                error["stockQuantity"] = "Campo requerido";
                return;
              }

              bool hasCategoryError = false;
              for (int i = 0; i < controller["categories"].length; i++) {
                if (controller["categories"][i].text.isEmpty) {
                  error["categories"][i] = "Campo requerido";
                  hasCategoryError = true;
                } else {
                  error["categories"][i] = null;
                }
              }

              if (hasCategoryError) return;
            });

            addProduct(controller);
            closeDialog();
          },
          child: Text("Adicionar"),
        ),
      ],
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

  void closeDialog() {
    Navigator.of(context).pop();
    resetController();
    resetError();
  }

  void resetController() {
    controller["name"].clear();
    controller["description"].clear();
    controller["code"].clear();
    controller["costPrice"].clear();
    controller["salePrice"].clear();
    controller["stockQuantity"].clear();
    controller["categories"].clear();
  }

  void resetError() {
    error["name"] = null;
    error["description"] = null;
    error["code"] = null;
    error["costPrice"] = null;
    error["salePrice"] = null;
    error["stockQuantity"] = null;
    error["categories"].clear();
  }
}
