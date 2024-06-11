import '../../podo/budgetary_stage.dart';
import '../repository_interfaces/budgetary_stage_repository.dart';

class BudgetaryStageCacheRepository extends BudgetaryStageRepository {
  static final Map<int, List<BudgetaryStage>> _cache = {};

  @override
  Future<List<BudgetaryStage>> get(int year) async {
    final cacheItem = _cache[year];
    return cacheItem ?? [];
  }

  Future<void> addAll(int year, List<BudgetaryStage> budgetaryStages) async {
    _cache[year] = budgetaryStages;
  }
}
