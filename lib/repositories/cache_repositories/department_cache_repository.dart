import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/department_expenditure.dart';
import '../repository_interfaces/department_repository.dart';

class DepartmentCacheRepository extends DepartmentRepository {
  static List<Department> _departments = [];
  static final Map<String, List<DepartmentExpenditure>> _departmentExpenditures = {};

  @override
  Future<List<Department>> get(int year) async {
    return _departments;
  }

  @override
  Future<void> addAll(int year, List<Department> departments) async {
    _departments = departments;
  }

  String getCacheKey(int year, BudgetaryStage budgetaryStage) {
    return "$year-${budgetaryStage.id}";
  }

  @override
  Future<List<DepartmentExpenditure>> getDepartmentExpenditure(int year, BudgetaryStage budgetaryStage) async {
    final cacheKey = getCacheKey(year, budgetaryStage);
    return _departmentExpenditures[cacheKey] ?? [];
  }

  Future<void> addDepartmentExpenditure(
    int year,
    BudgetaryStage budgetaryStage,
    List<DepartmentExpenditure> departmentExpenditures,
  ) async {
    final cacheKey = getCacheKey(year, budgetaryStage);
    _departmentExpenditures[cacheKey] = departmentExpenditures;
  }
}
