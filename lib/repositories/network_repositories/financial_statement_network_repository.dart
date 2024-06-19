import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/env.dart';
import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/financial_statement.dart';
import '../../services/auth_service.dart';
import '../repository_interfaces/financial_statement_repository.dart';

class FinancialStatementNetworkRepository extends FinancialStatementRepository {
  @override
  Future<List<FinancialStatement>> getRek2(int year, BudgetaryStage budgetaryStage) async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/rek2");
    uri = uri.replace(queryParameters: <String, dynamic>{
      "jns_ang": budgetaryStage.id,
      "periode": year.toString(),
    });
    final response = await http.get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});

    final data = jsonDecode(response.body)["data"] as List<dynamic>;
    List<FinancialStatement> financialStatements = data.map((financialStatementJson) {
      return FinancialStatement(
        accountCode: financialStatementJson["kd_rek2"] ?? "",
        accountName: financialStatementJson["nm_rek2"] ?? "",
        budgetOrTarget: double.tryParse(financialStatementJson["ang"]) ?? 0,
        realization: double.tryParse(financialStatementJson["realisasi"]) ?? 0,
        level: Level.kelompok,
      );
    }).toList();
    return financialStatements;
  }

  @override
  Future<List<FinancialStatement>> getRek4(int year, BudgetaryStage budgetaryStage, Department? department) async {
    final session = await AuthService.instance.getSession();
  String departmentKode ='';
  
  if (department?.code != null) {
     departmentKode = department!.code;
  }else{
     departmentKode ='';
  }

  if (departmentKode == 'All') {
    departmentKode ='';
  }

 
    Uri uri = Uri.parse("${Env.endpoint}/rek4");
    uri = uri.replace(queryParameters: <String, dynamic>{
      "jns_ang": budgetaryStage.id,
      "periode": year.toString(),
      "kd_skpd": departmentKode,

      
    });
    final response = await http.get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});
    print(budgetaryStage.id);
    print(year);
    print(departmentKode);
// error
    final data = jsonDecode(response.body)["data"] as List<dynamic>;
    
  List<FinancialStatement> financialStatements = data.map((financialStatementJson) {
    
      print(data);
      // final section = int.tryParse(financialStatementJson["section"]) ?? 2;
      final section = financialStatementJson["section"] ?? 2;
      print(section);
      return FinancialStatement(
        accountCode: financialStatementJson["kd_rek"] ?? "",
        accountName: financialStatementJson["nm_rek"] ?? "",
        budgetOrTarget: double.tryParse(financialStatementJson["ang"]) ?? 0,
        realization: double.tryParse(financialStatementJson["realisasi"]) ?? 0,
        level: Level.values[section - 1],
      );
    }).toList();
    return financialStatements;
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
