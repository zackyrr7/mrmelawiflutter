import 'dart:math';

import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/financial_statement.dart';
import '../repository_interfaces/financial_statement_repository.dart';

class FinancialStatementDummyRepository extends FinancialStatementRepository {
  @override
  Future<List<FinancialStatement>> getRek2(int year, BudgetaryStage budgetaryStage) async {
    return <FinancialStatement>[
      FinancialStatement(
        accountCode: "41",
        accountName: "Pendapatan 1",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "42",
        accountName: "Pendapatan 2",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "43",
        accountName: "Pendapatan 3",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "44",
        accountName: "Pendapatan 4",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "45",
        accountName: "Pendapatan 5",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "46",
        accountName: "Pendapatan 6",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "47",
        accountName: "Pendapatan 7",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "51",
        accountName: "Belanja 1",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "52",
        accountName: "Belanja 2",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "53",
        accountName: "Belanja 3",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "54",
        accountName: "Belanja 4",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "55",
        accountName: "Belanja 5",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "56",
        accountName: "Belanja 6",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "57",
        accountName: "Belanja 7",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "61",
        accountName: "Pembiayaan 1",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "62",
        accountName: "Pembiayaan 2",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "63",
        accountName: "Pembiayaan 3",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "64",
        accountName: "Pembiayaan 4",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "65",
        accountName: "Pembiayaan 5",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "66",
        accountName: "Pembiayaan 6",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
      FinancialStatement(
        accountCode: "67",
        accountName: "Pembiayaan 7",
        budgetOrTarget: Random().nextInt(500).toDouble(),
        realization: Random().nextInt(500).toDouble(),
        level: Level.kelompok,
      ),
    ];
  }

  @override
  Future<List<FinancialStatement>> getRek4(
    int year,
    BudgetaryStage budgetaryStage,
    Department? department,
  ) async {
    return [
      FinancialStatement(
        accountCode: "41",
        accountName: "Pendapatan A",
        budgetOrTarget: 20,
        realization: 20,
        level: Level.kelompok,
      ),
    ];
  }

  @override
  Future<void> setRek2(
    int year,
    BudgetaryStage budgetaryStage,
    List<FinancialStatement> financialStatements,
  ) async {}

  @override
  Future<void> setRek4(
    int year,
    BudgetaryStage budgetaryStage,
    Department? department,
    List<FinancialStatement> financialStatements,
  ) async {}
}
