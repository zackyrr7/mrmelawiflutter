import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class BudgetaryStage extends Equatable {
  final String? id;
  final String name;

  const BudgetaryStage({this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return name;
  }
}
