import 'package:collection/collection.dart';

import '../../podo/budgetary_stage.dart';
import '../../podo/department_expenditure.dart';
import 'order.dart';

class DepartmentExpenditureState {
  List<DepartmentExpenditure> departmentExpenditures;
  int year;
  List<BudgetaryStage> budgetaryStages;
  BudgetaryStage? budgetaryStage;
  Order order;

  List<DepartmentExpenditure> get orderedDepartmentExpenditure {
    switch (order.column) {
      case OrderColumn.kdSkpd:
        if (order.type == OrderType.asc) {
          return departmentExpenditures.sorted((DepartmentExpenditure a, DepartmentExpenditure b) {
            return a.department.code.compareTo(b.department.code);
          });
        } else {
          return departmentExpenditures.sorted((DepartmentExpenditure a, DepartmentExpenditure b) {
            return b.department.code.compareTo(a.department.code);
          });
        }
      case OrderColumn.anggaran:
        if (order.type == OrderType.asc) {
          return departmentExpenditures.sorted((a, b) {
            return (a.budget - b.budget).toInt();
          });
        } else {
          return departmentExpenditures.sorted((a, b) {
            return (b.budget - a.budget).toInt();
          });
        }
      case OrderColumn.realisasi:
        if (order.type == OrderType.asc) {
          return departmentExpenditures.sorted((a, b) {
            return (a.realization - b.realization).toInt();
          });
        } else {
          return departmentExpenditures.sorted((a, b) {
            return (b.realization - a.realization).toInt();
          });
        }
      default:
    }
    return departmentExpenditures;
  }

  DepartmentExpenditureState({
    required this.departmentExpenditures,
    required this.year,
    this.budgetaryStage,
    required this.budgetaryStages,
    required this.order,
  });

  DepartmentExpenditureState copyWith({
    List<DepartmentExpenditure>? departmentExpenditures,
    int? year,
    List<BudgetaryStage>? budgetaryStages,
    BudgetaryStage? budgetaryStage,
    bool nullableBudgetaryStage = false,
    Order? order,
  }) {
    return DepartmentExpenditureState(
      departmentExpenditures: departmentExpenditures ?? this.departmentExpenditures,
      year: year ?? this.year,
      budgetaryStages: budgetaryStages ?? this.budgetaryStages,
      budgetaryStage: nullableBudgetaryStage ? budgetaryStage : budgetaryStage ?? this.budgetaryStage,
      order: order ?? this.order,
    );
  }
}
