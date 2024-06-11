import 'package:flutter_bloc/flutter_bloc.dart';

import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/financial_statement.dart';
import '../../repositories/cache_repositories/budgetary_stage_cache_repository.dart';
import '../../repositories/cache_repositories/financial_statement_cache_repository.dart';
import '../../repositories/network_repositories/budgetary_stage_network_repository.dart';
import '../../repositories/network_repositories/financial_statement_network_repository.dart';
import 'lra_state.dart';

class LraCubit extends Cubit<LraState> {
  LraCubit({required int year}) : super(LraState(year: year)) {
    _fetchBudgetaryStage(state.year);
  }

  final repository = FinancialStatementNetworkRepository();
  final cacheRepository = FinancialStatementCacheRepository();

  final budgetaryStageRepository = BudgetaryStageNetworkRepository();
  final budgetaryStageCacheRepository = BudgetaryStageCacheRepository();

  void applyFilter({
    Department? department,
    required Level level,
    required BudgetaryStage budgetaryStage,
  }) {
    if (department != state.department ||
        budgetaryStage != state.budgetaryStage) {
      emit(state.copyWith(financialStatements: []));
      fetchLra(budgetaryStage, department);
    }
    emit(state.copyWith(
        department: department, level: level, budgetaryStage: budgetaryStage));
  }

  void setDepartment(Department? department) {
    emit(state.copyWith(financialStatements: [])..department = department);
    final budgetaryStage = state.budgetaryStage;
    if (budgetaryStage == null) return;
    fetchLra(budgetaryStage, department);
  }

  Future<void> fetchLra(
      BudgetaryStage budgetaryStage, Department? department) async {
    _fetchCache(budgetaryStage, department);
    _fetchNetwork(budgetaryStage, department);
  }

  Future<void> _fetchCache(
      BudgetaryStage budgetaryStage, Department? department) async {
    final cacheItem =
        await cacheRepository.getRek4(state.year, budgetaryStage, department);
    if (!isClosed) emit(state.copyWith(financialStatements: cacheItem));
  }

  Future<void> _fetchNetwork(
      BudgetaryStage budgetaryStage, Department? department) async {
    final financialStatements =
        await repository.getRek4(state.year, budgetaryStage, department);
    cacheNetworkResult(budgetaryStage, department, financialStatements);
    if (!isClosed)
      emit(state.copyWith(financialStatements: financialStatements));
  }

  void cacheNetworkResult(
    BudgetaryStage budgetaryStage,
    Department? department,
    List<FinancialStatement> financialStatements,
  ) {
    cacheRepository.setRek4(
        state.year, budgetaryStage, department, financialStatements);
  }

  void _fetchBudgetaryStage(int year) {
    _fetchCachedBudgetaryStage(year);
    _fetchNetworkBudgetaryStage(year);
  }

  void setBudgetaryStage(BudgetaryStage budgetaryStage) {
    emit(state.copyWith(budgetaryStage: budgetaryStage));
    fetchLra(budgetaryStage, state.department);
  }

  Future<void> _fetchCachedBudgetaryStage(int year) async {
    final budgetaryStages = await budgetaryStageCacheRepository.get(year);
    if (!isClosed && budgetaryStages.isNotEmpty)
      setBudgetaryStage(budgetaryStages.last);
  }

  Future<void> _fetchNetworkBudgetaryStage(int year) async {
    final budgetaryStages = await budgetaryStageRepository.get(year);
    await cacheBudgetaryStage(year, budgetaryStages);
    if (!isClosed && budgetaryStages.isNotEmpty)
      setBudgetaryStage(budgetaryStages.last);
  }

  Future<void> cacheBudgetaryStage(
      int year, List<BudgetaryStage> budgetaryStages) async {
    await budgetaryStageCacheRepository.addAll(year, budgetaryStages);
  }
}
