import 'package:equatable/equatable.dart';

import 'department.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String? password;
  final UserType type;
  final Department department;

  const User({
    required this.email,
    required this.name,
    this.password,
    required this.type,
    required this.department,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      name: json["name"],
      type: UserType.fromString(json["type"]),
      department: Department.fromJson(json["department"]),
    );
  }

  @override
  List<Object?> get props => [email, name, password, type];
}

enum UserType {
  general,
  accountManager;

  factory UserType.fromString(String value) {
    switch (value) {
      case "Account Manager":
        return UserType.accountManager;
      case "General":
        return UserType.general;
      default:
        throw Exception("Unknown User Type");
    }
  }

  @override
  String toString() {
    switch (this) {
      case UserType.accountManager:
        return "Account Manager";
      case UserType.general:
        return "General";
      default:
        throw Exception("Undefined Enum Value");
    }
  }
}