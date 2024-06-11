import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../constants/env.dart';
import '../../services/auth_service.dart';
import '../repository_interfaces/last_update_repository.dart';

class LastUpdateNetworkRepository extends LastUpdateRepository {
  @override
  Future<DateTime> get(int year) async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/lastUpdate");
    uri = uri.replace(queryParameters: <String, dynamic>{
      "periode": year.toString(),
    });
    final response = await http
        .get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});
    print(response);
    print(uri);

    String data = jsonDecode(response.body)["data"];
    return DateFormat("d MMMM y h:m:s", "id_ID").parse(data);
  }
}
