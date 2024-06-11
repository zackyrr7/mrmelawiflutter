import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/env.dart';
import '../../exceptions/network_exception.dart';
import '../../extensions/http_response_extension.dart';
import '../../services/auth_service.dart';
import '../repository_interfaces/account_repository.dart';

class AccountNetworkRepository extends AccountRepository {
  @override
  Future<void> resetPassword({required String oldPassword, required String newPassword}) async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/resetPassword");
    final response = await http.post(
      uri,
      headers: {"Authorization": "Bearer ${session?.jwt}", "Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      }),
    );
    if (!response.isSuccess) {
      final errorMessage = jsonDecode(response.body)["message"];
      throw NetworkException(errorMessage: errorMessage);
    }
  }
}
