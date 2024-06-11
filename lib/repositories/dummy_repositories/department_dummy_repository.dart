import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/department_expenditure.dart';
import '../repository_interfaces/department_repository.dart';

class DepartmentDummyRepository extends DepartmentRepository {
  @override
  Future<List<Department>> get(int year) async {
    return [
      const Department(code: "100292910", name: "Department A"),
      const Department(code: "100292911", name: "Department B"),
      const Department(code: "100292912", name: "Department C"),
      const Department(code: "100292913", name: "Department D"),
      const Department(code: "100292914", name: "Department E"),
    ];
  }

  @override
  Future<void> addAll(int year, List<Department> departments) async {}

  @override
  Future<List<DepartmentExpenditure>> getDepartmentExpenditure(int year, BudgetaryStage budgetaryStage) async {
    return [];
  }
}
