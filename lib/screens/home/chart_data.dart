import 'package:flutter/material.dart';

import '../../podo/financial_statement.dart';

class ChartData {
  FinancialStatement financialStatement;
  double yValue;
  Color? color;

  ChartData({required this.financialStatement, required this.yValue, this.color});
}
