import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/env.dart';
import '../../exceptions/network_exception.dart';
import '../../extensions/http_response_extension.dart';
import '../repository_interfaces/fiscal_year_repository.dart';

class FiscalYearNetworkRepository extends FiscalYearRepository {
  @override
  Future<List<int>> get() async {
    try {
      final response = await http.get(Uri.parse("${Env.endpoint}/tahunAnggaran"));

      if (!response.isSuccess) {
        final errorMessage = jsonDecode(response.body)["message"];
        throw NetworkException(errorMessage: errorMessage);
      }

      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => int.parse((e as Map<String, dynamic>)["tahun"] as String)).toList();
    } catch (error) {
      rethrow;
    }
  }
}
