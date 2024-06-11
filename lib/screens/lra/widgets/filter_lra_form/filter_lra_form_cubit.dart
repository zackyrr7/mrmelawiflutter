import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../podo/budgetary_stage.dart';
import '../../../../podo/department.dart';
import '../../../../podo/financial_statement.dart';
import '../../../../repositories/cache_repositories/budgetary_stage_cache_repository.dart';
import '../../../../repositories/cache_repositories/department_cache_repository.dart';
import '../../../../repositories/network_repositories/budgetary_stage_network_repository.dart';
import '../../../../repositories/network_repositories/department_network_repository.dart';
import 'filter_lra_form_state.dart';

class FilterLraFormCubit extends Cubit<FilterLraFormState> {
  FilterLraFormCubit(super.initialState) {
    _fetchDepartment();
    _fetchBudgetaryStage();
  }

  final departmentRepository = DepartmentNetworkRepository();
  final departmentCacheRepository = DepartmentCacheRepository();
  final budgetaryStageRepository = BudgetaryStageNetworkRepository();
  final budgetaryStageCacheRepository = BudgetaryStageCacheRepository();

  void setDepartment(Department? department) {
    emit(state.copyWith(department: department, nullableDepartment: true));
  }

  void setBudgetaryStage(BudgetaryStage? budgetaryStage) {
    emit(state.copyWith(budgetaryStage: budgetaryStage));
  }

  void setLevel(Level level) {
    emit(state.copyWith(level: level));
  }

  void _fetchDepartment() {
    _fetchCachedDepartment();
    _fetchNetworkDepartment();
  }

  Future<void> _fetchCachedDepartment() async {
    final year = state.year;
    final departments = await departmentCacheRepository.get(year);

    final newState = state.copyWith(
      departments: departments,
      department: departments.contains(state.department) ? state.department : null,
      nullableDepartment: true,
    );
    if (!isClosed) emit(newState);
  }

  Future<void> _fetchNetworkDepartment() async {
    final year = state.year;
    final departments = await departmentRepository.get(year);

    final newState = state.copyWith(
      departments: departments,
      department: departments.contains(state.department) ? state.department : null,
      nullableDepartment: true,
    );
    cacheDepartmentsNetworkResult(year, departments);
    if (!isClosed) emit(newState);
  }

  Future<void> cacheDepartmentsNetworkResult(int year, List<Department> departments) async {
    await departmentCacheRepository.addAll(year, departments);
  }

  void _fetchBudgetaryStage() {
    _fetchCachedBudgetaryStage();
    _fetchNetworkBudgetaryStage();
  }

  Future<void> _fetchCachedBudgetaryStage() async {
    final year = state.year;
    final budgetaryStages = await budgetaryStageCacheRepository.get(year);

    BudgetaryStage? budgetaryStage = budgetaryStages.firstWhereOrNull((element) => element == state.budgetaryStage);
    if (budgetaryStage == null && budgetaryStages.isNotEmpty) budgetaryStage = budgetaryStages.last;
    final newState = state.copyWith(
      budgetaryStages: budgetaryStages,
      budgetaryStage: budgetaryStage,
      nullableBudgetaryStage: true,
    );
    if (!isClosed) emit(newState);
  }

  Future<void> _fetchNetworkBudgetaryStage() async {
    final year = state.year;
    final budgetaryStages = await budgetaryStageRepository.get(year);

    BudgetaryStage? budgetaryStage = budgetaryStages.firstWhereOrNull((element) => element == state.budgetaryStage);
    if (budgetaryStage == null && budgetaryStages.isNotEmpty) {
      budgetaryStage = budgetaryStages.last;
    }
    final newState = state.copyWith(
      budgetaryStages: budgetaryStages,
      budgetaryStage: budgetaryStage,
      nullableBudgetaryStage: true,
    );
    cacheBudgetaryStagesNetworkResult(year, budgetaryStages);
    if (!isClosed) emit(newState);
  }

  Future<void> cacheBudgetaryStagesNetworkResult(int year, List<BudgetaryStage> budgetaryStages) async {
    await budgetaryStageCacheRepository.addAll(year, budgetaryStages);
  }
}
