import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/env.dart';
import '../extensions/http_response_extension.dart';
import '../podo/session.dart';
import '../podo/user.dart';

class AuthService {
  static AuthService? _instance;

  static AuthService get instance => _instance ?? (_instance = AuthService._());

  AuthService._();

  final storage = const FlutterSecureStorage();

  Future<Session> login({required String email, required String password}) async {
    final body = <String, dynamic>{
      "email": email,
      "password": password,
    };
    final response = await http.post(
      Uri.parse("${Env.endpoint}/login"),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    if (!response.isSuccess) return Future.error(Exception("Invalid credential"));

    final responseBody = jsonDecode(response.body);
    print(responseBody);

    final userMap = responseBody["user"] as Map<String, dynamic>;
    print(userMap);
    final user = User.fromJson(userMap);
    print(user);

    String jwt = responseBody["accessToken"];

    await storage.write(key: "jwt", value: jwt);
    await storage.write(key: "user", value: jsonEncode(userMap));
    print(jwt);

    return Session(jwt: jwt, user: user);
  }

  Future<void> logout() async {
    await storage.delete(key: "jwt");
    await storage.delete(key: "user");
  }

  Future<Session?> getSession() async {
    final jwt = await storage.read(key: "jwt");
    final userString = await storage.read(key: "user");

    if (jwt == null || userString == null) return null;

    final userJson = jsonDecode(userString);
    return Session(jwt: jwt, user: User.fromJson(userJson));
  }
}