import 'package:flutter_bloc/flutter_bloc.dart';

import '../../podo/budgetary_stage.dart';
import '../../podo/financial_statement.dart';
import '../../repositories/cache_repositories/budgetary_stage_cache_repository.dart';
import '../../repositories/cache_repositories/financial_statement_cache_repository.dart';
import '../../repositories/network_repositories/budgetary_stage_network_repository.dart';
import '../../repositories/network_repositories/financial_statement_network_repository.dart';
import '../../repositories/network_repositories/last_update_network_repository.dart';
import 'home_state.dart';
import 'types/account_type.dart';
import 'types/value_type.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required int year})
      : super(HomeState(
          valueType: ValueType.anggaran,
          accountType: AccountType.pendapatan,
          year: year,
          budgetaryStages: [],
        )) {
    fetchBudgetaryStage();
    _fetchLastUpdate(year: year);
  }

  final repository = FinancialStatementNetworkRepository();
  final cacheRepository = FinancialStatementCacheRepository();

  final budgetaryStageRepository = BudgetaryStageNetworkRepository();
  final budgetaryStageCacheRepository = BudgetaryStageCacheRepository();

  void fetchAccountBudgetExpenditures(BudgetaryStage budgetaryStage) {
    emit(state.copyWith(daftarBelanja: [], daftarPembiayaan: [], daftarPendapatan: []));
    _fetchLocal(budgetaryStage);
    _fetchRemote(budgetaryStage);
  }

  void cacheNetworkResult(BudgetaryStage budgetaryStage, List<FinancialStatement> financialStatements) {
    cacheRepository.setRek2(state.year, budgetaryStage, financialStatements);
  }

  Future<void> _fetchRemote(BudgetaryStage budgetaryStage) async {
    final financialStatements = await repository.getRek2(state.year, budgetaryStage);
    cacheNetworkResult(budgetaryStage, financialStatements);
    if (!isClosed) setfinancialStatements(financialStatements);
  }

  Future<void> _fetchLocal(BudgetaryStage budgetaryStage) async {
    final financialStatements = await cacheRepository.getRek2(state.year, budgetaryStage);
    if (!isClosed) setfinancialStatements(financialStatements);
  }

  void setfinancialStatements(List<FinancialStatement> financialStatements) {
    final daftarPendapatan = [...financialStatements.where((statement) => statement.accountCode.startsWith("4"))];
    final daftarBelanja = [...financialStatements.where((statement) => statement.accountCode.startsWith("5"))];
    final daftarPembiayaan = [...financialStatements.where((statement) => statement.accountCode.startsWith("6"))];

    final newState = state.copyWith(
      daftarBelanja: daftarBelanja,
      daftarPembiayaan: daftarPembiayaan,
      daftarPendapatan: daftarPendapatan,
    );
    emit(newState);
  }

  void setAccountType(AccountType accountType) {
    emit(state.copyWith(accountType: accountType));
  }

  void setValueType(ValueType valueType) {
    emit(state.copyWith(valueType: valueType));
  }

  void setBudgetaryStage(BudgetaryStage budgetaryStage) {
    emit(state.copyWith(budgetaryStage: budgetaryStage));
    fetchAccountBudgetExpenditures(budgetaryStage);
  }

  void fetchBudgetaryStage() {
    _fetchCachedBudgetaryStage();
    _fetchNetworkBudgetaryStage();
  }

  Future<void> _fetchCachedBudgetaryStage() async {
    final budgetaryStages = await budgetaryStageCacheRepository.get(state.year);
    if (!isClosed) {
      emit(state.copyWith(budgetaryStages: budgetaryStages, budgetaryStage: null));
      if (budgetaryStages.isNotEmpty) setBudgetaryStage(budgetaryStages.last);
    }
  }

  Future<void> _fetchNetworkBudgetaryStage() async {
    final budgetaryStages = await budgetaryStageRepository.get(state.year);
    await cacheBudgetaryStage(budgetaryStages);
    if (!isClosed) {
      emit(state.copyWith(budgetaryStages: budgetaryStages, budgetaryStage: null));
      if (budgetaryStages.isNotEmpty) setBudgetaryStage(budgetaryStages.last);
    }
  }

  Future<void> cacheBudgetaryStage(List<BudgetaryStage> budgetaryStages) async {
    await budgetaryStageCacheRepository.addAll(state.year, budgetaryStages);
  }

  Future<void> _fetchLastUpdate({required int year}) async {
    final lastUpdateRepository = LastUpdateNetworkRepository();
    final lastUpdate = await lastUpdateRepository.get(year);
    emit(state.copyWith(lastUpdate: lastUpdate));
  }
}
