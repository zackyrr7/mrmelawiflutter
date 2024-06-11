import 'package:equatable/equatable.dart';

import 'user.dart';

class Session extends Equatable {
  final User user;
  final String jwt;

  const Session({required this.jwt, required this.user});

  @override
  List<Object?> get props => [user, jwt];
}
