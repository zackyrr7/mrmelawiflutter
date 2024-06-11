import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/financial_statement.dart';
import '../repository_interfaces/financial_statement_repository.dart';

class FinancialStatementCacheRepository extends FinancialStatementRepository {
  static final Map<int, List<FinancialStatement>> _rek2FinancialStatements = {};
  static final Map<String, List<FinancialStatement>> _rek4FinancialStatements = {};

  @override
  Future<List<FinancialStatement>> getRek2(int year, BudgetaryStage budgetaryStage) async {
    return _rek2FinancialStatements[year] ?? [];
  }

  @override
  Future<List<FinancialStatement>> getRek4(int year, BudgetaryStage budgetaryStage, Department? department) async {
    String cacheKey = getCacheKey(year, budgetaryStage, department);
    return _rek4FinancialStatements[cacheKey] ?? [];
  }

  String getCacheKey(int year, BudgetaryStage budgetaryStage, Department? department) {
    return "$year-${budgetaryStage.id}-${department?.code}";
  }

  @override
  Future<void> setRek2(int year, BudgetaryStage budgetaryStage, List<FinancialStatement> financialStatements) async {
    _rek2FinancialStatements[year] = financialStatements;
  }

  @override
  Future<void> setRek4(
    int year,
    BudgetaryStage budgetaryStage,
    Department? department,
    List<FinancialStatement> financialStatements,
  ) async {
    String cacheKey = getCacheKey(year, budgetaryStage, department);
    _rek4FinancialStatements[cacheKey] = financialStatements;
  }
}
