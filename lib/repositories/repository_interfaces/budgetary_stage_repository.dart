import '../../podo/budgetary_stage.dart';

abstract class BudgetaryStageRepository {
  Future<List<BudgetaryStage>> get(int year);
}
