import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../podo/budgetary_stage.dart';
import '../../podo/department_expenditure.dart';
import '../../repositories/cache_repositories/budgetary_stage_cache_repository.dart';
import '../../repositories/cache_repositories/department_cache_repository.dart';
import '../../repositories/network_repositories/budgetary_stage_network_repository.dart';
import '../../repositories/network_repositories/department_network_repository.dart';
import 'department_expenditure_state.dart';
import 'order.dart';

class DepartmentExpenditureCubit extends Cubit<DepartmentExpenditureState> {
  DepartmentExpenditureCubit({required int year})
      : super(DepartmentExpenditureState(
          departmentExpenditures: [],
          year: year,
          budgetaryStages: [],
          order: Order(column: OrderColumn.kdSkpd, type: OrderType.asc),
        )) {
    _fetchBudgetaryStage(state.year);
  }

  final repository = DepartmentNetworkRepository();
  final cacheRepository = DepartmentCacheRepository();

  final budgetaryStageRepository = BudgetaryStageNetworkRepository();
  final budgetaryStageCacheRepository = BudgetaryStageCacheRepository();

  Future<void> _fetchLocal(BudgetaryStage budgetaryStage) async {
    final departmentExpenditures = await cacheRepository.getDepartmentExpenditure(state.year, budgetaryStage);
    if (!isClosed) emit(state.copyWith(departmentExpenditures: departmentExpenditures));
  }

  Future<void> _fetchRemote(BudgetaryStage budgetaryStage) async {
    final departmentExpenditures = await repository.getDepartmentExpenditure(state.year, budgetaryStage);
    cacheNetworkResult(budgetaryStage, departmentExpenditures);
    if (!isClosed) emit(state.copyWith(departmentExpenditures: departmentExpenditures));
  }

  Future<void> cacheNetworkResult(
    BudgetaryStage budgetaryStage,
    List<DepartmentExpenditure> departmentExpenditures,
  ) async {
    await cacheRepository.addDepartmentExpenditure(state.year, budgetaryStage, departmentExpenditures);
  }

  void fetchDepartment(BudgetaryStage budgetaryStage) {
    _fetchLocal(budgetaryStage);
    _fetchRemote(budgetaryStage);
  }

  void _fetchBudgetaryStage(int year) {
    _fetchLocalBudgetaryStage(year);
    _fetchNetworkBudgetaryStage(year);
  }

  Future<void> _fetchLocalBudgetaryStage(int year) async {
    final budgetaryStages = await budgetaryStageCacheRepository.get(year);
    if (!isClosed) setBudgetaryStages(budgetaryStages);
  }

  Future<void> _fetchNetworkBudgetaryStage(int year) async {
    final budgetaryStages = await budgetaryStageRepository.get(year);
    cacheBudgetaryStage(budgetaryStages);
    if (!isClosed) setBudgetaryStages(budgetaryStages);
  }

  Future<void> cacheBudgetaryStage(List<BudgetaryStage> budgetaryStages) async {
    await budgetaryStageCacheRepository.addAll(state.year, budgetaryStages);
  }

  void setBudgetaryStage(BudgetaryStage budgetaryStage) {
    emit(state.copyWith(budgetaryStage: budgetaryStage));
    fetchDepartment(budgetaryStage);
  }

  void setBudgetaryStages(List<BudgetaryStage> budgetaryStages) {
    BudgetaryStage? budgetaryStage = budgetaryStages.firstWhereOrNull((element) => element == state.budgetaryStage);
    if (budgetaryStage == null && budgetaryStages.isNotEmpty) budgetaryStage = budgetaryStages.last;
    final newState = state.copyWith(
      budgetaryStages: budgetaryStages,
      budgetaryStage: budgetaryStage,
      nullableBudgetaryStage: true,
    );
    if (!isClosed) emit(newState);
    if (budgetaryStage != null) fetchDepartment(budgetaryStage);
  }

  void setOrderColumn(OrderColumn column) {
    emit(state.copyWith(order: state.order.copyWith(column: column)));
  }

  void setOrderType(OrderType type) {
    emit(state.copyWith(order: state.order.copyWith(type: type)));
  }
}
