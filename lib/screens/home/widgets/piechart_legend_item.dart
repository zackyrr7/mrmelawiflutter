import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extensions/double_extension.dart';
import '../chart_data.dart';

class PieChartLegendItem extends StatelessWidget {
  final ChartData chartData;
  final double sum;
  const PieChartLegendItem({super.key, required this.chartData, required this.sum});

  @override
  Widget build(BuildContext context) {
    final statement = chartData.financialStatement;
    final value = chartData.yValue;
    final percentage = (value * 100 / sum).toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.pie_chart_rounded, color: chartData.color),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(statement.accountName),
                Text(
                  "${value.thousandSeparated} ($percentage%)",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
