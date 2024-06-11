import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/department_expenditure.dart';

abstract class DepartmentRepository {
  Future<List<Department>> get(int year);

  Future<void> addAll(int year, List<Department> departments);

  Future<List<DepartmentExpenditure>> getDepartmentExpenditure(int year, BudgetaryStage budgetaryStage);
}
