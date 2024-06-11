import '../../constants/config.dart';
import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/financial_statement.dart';

class LraState {
  List<FinancialStatement> financialStatements;
  Department? department;
  BudgetaryStage? budgetaryStage;
  Level level;
  int year;

  LraState({
    List<FinancialStatement>? financialStatements,
    this.department,
    this.budgetaryStage,
    Level? level,
    int? year,
  })  : financialStatements = financialStatements ?? [],
        level = level ?? Level.kelompok,
        year = year ?? Config.daftarTahunAnggaran.first;

  LraState copyWith({
    List<FinancialStatement>? financialStatements,
    Department? department,
    Level? level,
    int? year,
    BudgetaryStage? budgetaryStage,
  }) {
    return LraState(
      financialStatements: financialStatements ?? this.financialStatements,
      department: department ?? this.department,
      level: level ?? this.level,
      year: year ?? this.year,
      budgetaryStage: budgetaryStage ?? this.budgetaryStage,
    );
  }
}
