import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/env.dart';
import '../../podo/budgetary_stage.dart';
import '../../services/auth_service.dart';
import '../repository_interfaces/budgetary_stage_repository.dart';

class BudgetaryStageNetworkRepository extends BudgetaryStageRepository {
  @override
  Future<List<BudgetaryStage>> get(int year) async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/jenisAnggaran");
    uri = uri.replace(queryParameters: <String, dynamic>{"periode": year.toString()});
    final response = await http.get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});

    final data = jsonDecode(response.body) as List<dynamic>;
    List<BudgetaryStage> budgetaryStages = data.map((budgetaryStageJson) {
      String? jnsAng = budgetaryStageJson["jns_ang"];
      String name = budgetaryStageJson["name"];
      return BudgetaryStage(id: jnsAng, name: name);
    }).toList();
    return budgetaryStages;
  }
}
