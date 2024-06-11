import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class FiscalYearSelectionState extends Equatable {
  const FiscalYearSelectionState();

  @override
  List<Object?> get props => [];
}

class LoadingFiscalYear extends FiscalYearSelectionState {}

class FiscalYearLoaded extends FiscalYearSelectionState {
  final List<int> years;

  const FiscalYearLoaded({required this.years});

  @override
  List<Object?> get props => [...super.props, years];
}

class ErrorLoadingFiscalYear extends FiscalYearSelectionState {
  final String errorMessage;

  const ErrorLoadingFiscalYear({required this.errorMessage});

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
