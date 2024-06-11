import '../../podo/user.dart';
import '../repository_interfaces/user_repository.dart';

class UserCacheRepository extends UserRepository {
  static List<User> _users = [];

  @override
  Future<void> add(User user) async {}

  @override
  Future<void> delete(User user) async {}

  @override
  Future<List<User>> get() async {
    return _users;
  }

  @override
  Future<void> set(List<User> users) async {
    _users = users;
  }
}
