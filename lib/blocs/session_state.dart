import 'package:equatable/equatable.dart';

import '../podo/session.dart';

abstract class SessionState extends Equatable {}

class SessionLoggedOut extends SessionState {
  @override
  List<Object?> get props => [];
}

class SessionLoggedIn extends SessionState {
  final Session session;

  SessionLoggedIn({required this.session});

  @override
  List<Object?> get props => [session];
}
