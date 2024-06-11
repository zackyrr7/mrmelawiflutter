import 'package:flutter/widgets.dart';

@immutable
class ResetPasswordState {}

class ResettingPasswordState extends ResetPasswordState {}

class ErrorResetPasswordState extends ResetPasswordState {
  final String errorMessage;

  ErrorResetPasswordState({required this.errorMessage});
}

class SuccessResetPasswordState extends ResetPasswordState {
  final String message;

  SuccessResetPasswordState({required this.message});
}

class ResetPasswordInitialState extends ResetPasswordState {}
