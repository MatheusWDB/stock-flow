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
        'type': movement.type.displayName,
        'quantity': movement.quantity,
      });
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 350,
      height: 300,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 40),
        data: chartData,
        variables: {
          'date': Variable(
            accessor: (Map map) => map['date'] as String,
          ),
          'type': Variable(
            accessor: (Map map) => map['type'] as String,
          ),
          'quantity': Variable(
            accessor: (Map map) => map['quantity'] as num,
          ),
        },
        marks: [
          IntervalMark(
            position: Varset('date') * Varset('quantity') / Varset('type'),
            color: ColorEncode(
              variable: 'type',
              values: [Colors.green, Colors.red],
            ),
            size: SizeEncode(value: 10),
            modifiers: [DodgeModifier(ratio: 0.05)],
          ),
        ],
        coord: RectCoord(
          horizontalRangeUpdater: Defaults.horizontalRangeEvent,
        ),
        axes: [
          Defaults.horizontalAxis..tickLine = TickLine(),
          Defaults.verticalAxis,
        ],
        selections: {
          'tap': PointSelection(
            variable: 'date',
          )
        },
        //tooltip: TooltipGuide(multiTuples: true),
        crosshair: CrosshairGuide(),
        annotations: [
          CustomAnnotation(
              renderer: (_, size) => [
                    CircleElement(
                        center: const Offset(25, 290),
                        radius: 5,
                        style: PaintStyle(fillColor: Colors.green))
                  ],
              anchor: (p0) => const Offset(0, 0)),
          TagAnnotation(
            label: Label(
              'Entrada',
              LabelStyle(
                  textStyle: Defaults.textStyle, align: Alignment.centerRight),
            ),
            anchor: (size) => const Offset(34, 290),
          ),
          CustomAnnotation(
              renderer: (_, size) => [
                    CircleElement(
                        center: Offset(25 + size.width / 5, 290),
                        radius: 5,
                        style: PaintStyle(fillColor: Colors.red))
                  ],
              anchor: (p0) => const Offset(0, 0)),
          TagAnnotation(
            label: Label(
              'Saída',
              LabelStyle(
                  textStyle: Defaults.textStyle, align: Alignment.centerRight),
            ),
            anchor: (size) => Offset(34 + size.width / 5, 290),
          ),
        ],
      ),
    );
  }
}
