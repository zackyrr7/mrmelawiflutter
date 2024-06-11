import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chart_data.dart';
import '../home_cubit.dart';
import 'piechart_legend_item.dart';

class PieChartLegend extends StatelessWidget {
  const PieChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final chartData = context.select<HomeCubit, List<ChartData>>((value) => value.state.chartData);
    final sum = chartData.fold(0.0, (prev, datum) => prev + datum.yValue);
    return Column(
      children: [
        for (final datum in chartData) PieChartLegendItem(chartData: datum, sum: sum),
        const Padding(padding: EdgeInsets.only(bottom: 8)),
      ],
    );
  }
}
