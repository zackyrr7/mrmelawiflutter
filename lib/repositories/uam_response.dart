import '../podo/user.dart';

class UamResponse {
  final List<User> users;
  final int recordsCount;

  UamResponse({
    required this.users,
    required this.recordsCount,
  });
}
