import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/env.dart';
import '../../extensions/http_response_extension.dart';
import '../../podo/user.dart';
import '../../services/auth_service.dart';
import '../repository_interfaces/user_repository.dart';

class UserNetworkRepository extends UserRepository {
  @override
  Future<void> add(User user) async {
    try {
      final session = await AuthService.instance.getSession();

      Uri uri = Uri.parse("${Env.endpoint}/addUser");
      final body = <String, dynamic>{
        "email": user.email,
        "name": user.name,
        "password": user.password,
        "type": user.type.toString(),
        "department": user.department.toJson(),
      };
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${session?.jwt}",
        },
      );
      final message = jsonDecode(response.body)["message"];

      if (!response.isSuccess) return Future.error(Exception(message is String ? message : "Unknown Error"));
    } catch (err) {
      return Future.error(Exception(err));
    }
  }

  @override
  Future<void> delete(User user) async {
    try {
      final session = await AuthService.instance.getSession();

      Uri uri = Uri.parse("${Env.endpoint}/deleteUser");
      final body = <String, dynamic>{
        "email": user.email,
      };
      final response = await http.delete(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${session?.jwt}",
        },
      );
      final message = jsonDecode(response.body)["message"];

      if (!response.isSuccess) return Future.error(Exception(message is String ? message : "Unknown Error"));
    } catch (err) {
      return Future.error(Exception(err));
    }
  }

  @override
  Future<List<User>> get() async {
    final session = await AuthService.instance.getSession();

    Uri uri = Uri.parse("${Env.endpoint}/user");
    final response = await http.get(uri, headers: {"Authorization": "Bearer ${session?.jwt}"});

    final data = jsonDecode(response.body)["data"] as List<dynamic>;
    final users = data.map((userJson) {
      return User.fromJson(userJson);
    }).toList();
    return users;
  }

  @override
  Future<void> set(List<User> users) async {}
}
