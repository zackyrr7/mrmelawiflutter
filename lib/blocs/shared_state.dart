import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class SharedState extends Equatable {
  final int? selectedYear;

  const SharedState({this.selectedYear});

  @override
  List<Object?> get props => [selectedYear];

  SharedState copyWith({int? selectedYear}) {
    return SharedState(
      selectedYear: selectedYear ?? this.selectedYear,
    );
  }
}
