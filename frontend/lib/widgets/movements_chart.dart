import 'package:flutter/material.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

class MovementsChart extends StatefulWidget {
  const MovementsChart({
    required this.movements,
    super.key,
  });

  final List<StockMovement> movements;
  @override
  State<MovementsChart> createState() => _MovementsChartState();
}

class _MovementsChartState extends State<MovementsChart> {
  @override
  void initState() {
    super.initState();
    movements = widget.movements;
  }

  List<StockMovement> movements = [];

  @override
  Widget build(BuildContext context) {
    final chartData = <Map<String, dynamic>>[];

    final formatter = DateFormat('dd/MM');

    for (StockMovement movement in movements) {
      chartData.add({
        'date': formatter.format(movement.date!.toLocal()),
        'type': movement.type.name,
        'quantity': movement.quantity,
      });
    }
    return SizedBox(
      height: 300,
      child: Chart(
        data: chartData,
        variables: {
          'date': Variable(
            accessor: (Map map) => map['date'] as String,
          ),
          'quantity': Variable(
            accessor: (Map map) => map['quantity'] as num,
          ),
          'type': Variable(
            accessor: (Map map) => map['type'] as String,
          ),
        },
        marks: [
          IntervalMark(
            position: Varset('date') * Varset('quantity'),
            color: ColorEncode(
              variable: 'type',
              values: [Colors.green, Colors.red],
              updaters: {
                'entrada': {
                  true: (cor) => Colors.green,
                  false: (cor) => Colors.yellow,
                },
                'saída': {
                  true: (cor) => Colors.red,
                  false: (cor) => Colors.yellow,
                },
              },
            ),
          ),
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
      ),
    );
  }
}
