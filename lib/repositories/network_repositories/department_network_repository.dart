import 'dart:convert';

import "package:http/http.dart" as http;

import '../../constants/env.dart';
import '../../podo/budgetary_stage.dart';
import '../../podo/department.dart';
import '../../podo/department_expenditure.dart';
import '../../services/auth_service.dart';
import '../repository_interfaces/department_repository.dart';

class DepartmentNetworkRepository extends DepartmentRepository {
  @override
  Future<List<Department>> get(int year) async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/skpd");
    uri = uri.replace(queryParameters: <String, dynamic>{"periode": year.toString()});
    final response = await http.get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});

    final data = jsonDecode(response.body)["data"] as List<dynamic>;
    List<Department> departments = data.map((departmentJson) {
      return Department(code: departmentJson["kd_skpd"], name: departmentJson["nm_skpd"]);
    }).toList();
    return departments;
  }

  @override
  Future<void> addAll(int year, List<Department> departments) async {}

  @override
  Future<List<DepartmentExpenditure>> getDepartmentExpenditure(int year, BudgetaryStage budgetaryStage) async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/realisasiSkpd");
    uri = uri.replace(queryParameters: <String, dynamic>{
      "periode": year.toString(),
      "jns_ang": budgetaryStage.id,
    });
    final response = await http.get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});

    final data = jsonDecode(response.body)["data"] as List<dynamic>;
    List<DepartmentExpenditure> departmentExpenditures = data.map((expenditureJson) {
      final department = Department(code: expenditureJson["kd_skpd"], name: expenditureJson["nm_skpd"]);
      return DepartmentExpenditure(
        department: department,
        budget: double.tryParse(expenditureJson["anggaran"]) ?? 0,
        realization: double.tryParse(expenditureJson["realisasi"]) ?? 0,
      );
    }).toList();
    return departmentExpenditures;
  }
}
