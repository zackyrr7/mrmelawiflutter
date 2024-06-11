import 'package:collection/collection.dart';

import '../../constants/color_palette.dart';
import '../../podo/budgetary_stage.dart';
import '../../podo/financial_statement.dart';
import 'chart_data.dart';
import 'types/account_type.dart';
import 'types/value_type.dart';

class HomeState {
  final _colors = ColorPalette.pieChartPalette;

  final List<FinancialStatement> _daftarPendapatan;
  final List<FinancialStatement> _daftarBelanja;
  final List<FinancialStatement> _daftarPembiayaan;

  ValueType valueType;
  AccountType accountType;
  final int year;
  List<BudgetaryStage> budgetaryStages;
  BudgetaryStage? budgetaryStage;
  DateTime? lastUpdate;

  List<ChartData> get chartData {
    List<FinancialStatement> financialStatements = [];
    if (accountType == AccountType.belanja) {
      financialStatements = _daftarBelanja;
    } else if (accountType == AccountType.pendapatan) {
      financialStatements = _daftarPendapatan;
    } else if (accountType == AccountType.pembiayaan) {
      financialStatements = _daftarPembiayaan;
    }

    return financialStatements.mapIndexed((index, financialStatement) {
      return ChartData(
        financialStatement: financialStatement,
        yValue: valueType.isAnggaran ? financialStatement.budgetOrTarget : financialStatement.realization,
        color: _colors[index % _colors.length],
      );
    }).toList();
  }

  HomeState({
    required this.valueType,
    required this.accountType,
    required this.year,
    required this.budgetaryStages,
    this.budgetaryStage,
    this.lastUpdate,
    List<FinancialStatement>? daftarPendapatan,
    List<FinancialStatement>? daftarBelanja,
    List<FinancialStatement>? daftarPembiayaan,
  })  : _daftarPendapatan = daftarPendapatan ?? [],
        _daftarBelanja = daftarBelanja ?? [],
        _daftarPembiayaan = daftarPembiayaan ?? [];

  HomeState copyWith({
    ValueType? valueType,
    AccountType? accountType,
    int? year,
    DateTime? lastUpdate,
    List<BudgetaryStage>? budgetaryStages,
    BudgetaryStage? budgetaryStage,
    List<FinancialStatement>? daftarPendapatan,
    List<FinancialStatement>? daftarBelanja,
    List<FinancialStatement>? daftarPembiayaan,
  }) {
    return HomeState(
      valueType: valueType ?? this.valueType,
      accountType: accountType ?? this.accountType,
      year: year ?? this.year,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      budgetaryStages: budgetaryStages ?? this.budgetaryStages,
      budgetaryStage: budgetaryStage ?? this.budgetaryStage,
      daftarPendapatan: daftarPendapatan ?? _daftarPendapatan,
      daftarBelanja: daftarBelanja ?? _daftarBelanja,
      daftarPembiayaan: daftarPembiayaan ?? _daftarPembiayaan,
    );
  }
}
