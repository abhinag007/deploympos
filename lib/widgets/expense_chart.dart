import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseChart extends StatelessWidget {
  const ExpenseChart(this.seriesList, {required this.animate});

  final List<charts.Series> seriesList;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: charts.PieChart(
            seriesList,
            animate: animate,
            animationDuration: const Duration(seconds: 1),
            defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 12,
                strokeWidthPx: 0,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                    labelPadding: 0,
                    showLeaderLines: false,
                    outsideLabelStyleSpec: const charts.TextStyleSpec(
                      fontSize: 10,
                      color: charts.MaterialPalette.black,
                    ),
                  ),
                ]),
            behaviors: [
              charts.DatumLegend(
                position: charts.BehaviorPosition.end,
                outsideJustification: charts.OutsideJustification.start,
                horizontalFirst: false,
                desiredMaxColumns: 1,
                cellPadding: const EdgeInsets.only(right: 4, bottom: 4),
                entryTextStyle: const charts.TextStyleSpec(
                    fontSize: 12, color: charts.MaterialPalette.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
