import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String code;
  final String name;

  const Department({
    required this.code,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [code, name];

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(code: json["kd_skpd"], name: json["nm_skpd"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "kd_skpd": code,
      "nm_skpd": name,
    };
  }
}
