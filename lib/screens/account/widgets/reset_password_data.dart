import 'package:flutter/foundation.dart';

@immutable
class ResetPasswordData {
  final String oldPassword;
  final String newPassword;

  const ResetPasswordData({required this.oldPassword, required this.newPassword});
}
