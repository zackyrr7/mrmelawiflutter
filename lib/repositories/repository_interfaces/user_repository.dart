import '../../podo/user.dart';

abstract class UserRepository {
  Future<List<User>> get();

  Future<void> set(List<User> users);

  Future<void> add(User user);

  Future<void> delete(User user);
}
