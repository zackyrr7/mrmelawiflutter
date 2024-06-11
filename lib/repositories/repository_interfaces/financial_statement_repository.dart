import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/financial_statement.dart';

abstract class FinancialStatementRepository {
  Future<List<FinancialStatement>> getRek2(
    int year,
    BudgetaryStage budgetaryStage,
  );

  Future<void> setRek2(
    int year,
    BudgetaryStage budgetaryStage,
    List<FinancialStatement> financialStatements,
  );

  Future<List<FinancialStatement>> getRek4(
    int year,
    BudgetaryStage budgetaryStage,
    Department? department,
  );

  Future<void> setRek4(
    int year,
    BudgetaryStage budgetaryStage,
    Department? department,
    List<FinancialStatement> financialStatements,
  );
}
