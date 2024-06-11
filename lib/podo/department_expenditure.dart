import 'package:equatable/equatable.dart';

import 'department.dart';

class DepartmentExpenditure extends Equatable {
  final Department department;
  final double budget;
  final double realization;

  const DepartmentExpenditure({
    required this.department,
    required this.budget,
    required this.realization,
  });

  @override
  List<Object?> get props => [department, budget, realization];
}
