import '../../podo/session.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  Session session;

  LoginSuccess(this.session);
}

class LoginError extends LoginState {
  String error;

  LoginError(this.error);
}
