import '../../../../podo/budgetary_stage.dart';
import '../../../../podo/department.dart';
import '../../../../podo/financial_statement.dart';

class FilterLraFormState {
  final int year;
  final Department? department;
  final List<Department> departments;
  final Level level;
  final List<Level> levels;
  final List<BudgetaryStage> budgetaryStages;
  final BudgetaryStage? budgetaryStage;

  FilterLraFormState({
    required this.year,
    required this.level,
    required this.levels,
    this.department,
    this.departments = const [],
    this.budgetaryStage,
    this.budgetaryStages = const [],
  });

  /// Create a new instance of FilterLraFormState while replacing its property if provided, otherwise set to its original value from the original Instance.
  ///
  /// @param nullableDepartment By set this to true, it will replace department property even if it is null or not provided (Default to false).
  FilterLraFormState copyWith({
    List<Level>? levels,
    Level? level,
    Department? department,
    List<Department>? departments,
    BudgetaryStage? budgetaryStage,
    List<BudgetaryStage>? budgetaryStages,
    bool nullableDepartment = false,
    bool nullableBudgetaryStage = false,
  }) {
    return FilterLraFormState(
      year: year,
      levels: levels ?? this.levels,
      level: level ?? this.level,
      departments: departments ?? this.departments,
      department: nullableDepartment ? department : department ?? this.department,
      budgetaryStage: nullableBudgetaryStage ? budgetaryStage : budgetaryStage ?? this.budgetaryStage,
      budgetaryStages: budgetaryStages ?? this.budgetaryStages,
    );
  }

  FilterLraFormState withModifiedDepartment(Department? department) {
    return FilterLraFormState(
      year: year,
      level: level,
      levels: levels,
      department: department,
      departments: departments,
    );
  }
}
