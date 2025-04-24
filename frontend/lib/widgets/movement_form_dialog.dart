import 'package:flutter/material.dart';
import 'package:frontend/enums/type_enum.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:frontend/services/stock_movement_service.dart';

class MovementFormDialog extends StatefulWidget {
  const MovementFormDialog({
    required this.userId,
    required this.products,
    required this.getAllProductsAndMovements,
    super.key,
  });

  final int userId;
  final List<Product> products;
  final Function() getAllProductsAndMovements;

  @override
  State<MovementFormDialog> createState() => _MovementFormDialogState();
}

class _MovementFormDialogState extends State<MovementFormDialog> {
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    products = widget.products;
    getAllProductsAndMovements = widget.getAllProductsAndMovements;
  }

  late int userId;
  List<Product> products = [];
  late Function() getAllProductsAndMovements;

  Map<String, dynamic> controller = {
    'productId': null,
    'type': null,
    'quantity': TextEditingController(),
  };
  Map<String, String?> error = {
    'productId': null,
    'type': null,
    'quantity': null,
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => closeDialog(),
          child: const Text(
            'Cancelar',
          ),
        ),
        TextButton(
          onPressed: () {
            final List<String> attributes = ['productId', 'type'];

            for (String attribute in attributes) {
              if (controller[attribute] == null) {
                setState(() {
                  error[attribute] =
                      'Escolha um ${attribute == 'productId' ? 'produto' : 'tipo'}';
                });
                return;
              }
            }

            if (controller['quantity'].text.isEmpty ||
                int.tryParse(controller['quantity'].text)! <= 0) {
              setState(() {
                error['quantity'] = 'Maior que 0';
              });
              return;
            }

            saveMovement();
          },
          child: const Text('Salvar'),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          SingleChildScrollView(
            child: DropdownMenu(
              dropdownMenuEntries: products.map((p) {
                return DropdownMenuEntry(
                  value: p.productId,
                  label: p.name,
                );
              }).toList(),
              errorText: error['productId'],
              label: const Text('Produto'),
              onSelected: (newValue) {
                controller['productId'] = newValue;
                setState(() {
                  error['productId'] = null;
                });
              },
              width: MediaQuery.of(context).size.width * 0.48,
            ),
          ),
          DropdownMenu(
            dropdownMenuEntries: TypeEnum.values.map((type) {
              return DropdownMenuEntry(
                value: type,
                label: type.displayName,
              );
            }).toList(),
            errorText: error['type'],
            label: const Text('Tipo'),
            onSelected: (newValue) {
              controller['type'] = newValue;
              setState(() {
                error['type'] = null;
              });
            },
            width: MediaQuery.of(context).size.width * 0.32,
          ),
          TextField(
            controller: controller['quantity'],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.28,
              ),
              errorText: error['quantity'],
              label: const Text(
                'Quantidade',
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (error['quantity'] != null) {
                setState(() {
                  error['quantity'] = null;
                });
              }
            },
            textAlign: TextAlign.center,
          ),
        ],
      ),
      title: const Text('Nova movimentação'),
    );
  }

  void closeDialog() {
    Navigator.of(context).pop();
    resetController();
    resetError();
  }

  void resetController() {
    controller['productId'] = null;
    controller['type'] = null;
    controller['quantity'].clear();
  }

  void resetError() {
    error['productId'] = null;
    error['type'] = null;
    error['quantity'] = null;
  }

  void saveMovement() async {
    final TypeEnum type = controller['type'];

    final StockMovement newMovement = StockMovement(
      type: type,
      quantity: int.tryParse(controller['quantity'].text)!,
      productId: controller['productId'],
    );

    try {
      await StockMovementService.createStockMovement(newMovement, userId);

      getAllProductsAndMovements();
      closeDialog();
    } catch (e) {
      debugPrint('Erro ao salvar movimentação: $e');
    }
  }
}
