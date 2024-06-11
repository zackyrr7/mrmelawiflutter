import '../../podo/department.dart';
import '../../podo/user.dart';
import '../repository_interfaces/user_repository.dart';

class UserDummyRepository extends UserRepository {
  static final List<User> _users = [
    const User(
      email: "email-1@mail.co.id",
      name: "Name 1",
      type: UserType.accountManager,
      department: Department(code: "100292910", name: "Department A"),
    ),
    const User(
      email: "email-2@mail.co.id",
      name: "Name 2",
      type: UserType.general,
      department: Department(code: "100292910", name: "Department A"),
    ),
    const User(
      email: "email-3@mail.co.id",
      name: "Name 3",
      type: UserType.general,
      department: Department(code: "100292910", name: "Department A"),
    ),
    const User(
      email: "email-4@mail.co.id",
      name: "Name 4",
      type: UserType.general,
      department: Department(code: "100292910", name: "Department A"),
    ),
    const User(
      email: "email-5@mail.co.id",
      name: "Name 5",
      type: UserType.general,
      department: Department(code: "100292910", name: "Department A"),
    ),
    const User(
      email: "email-6@mail.co.id",
      name: "Name 6",
      type: UserType.general,
      department: Department(code: "100292910", name: "Department A"),
    ),
  ];

  @override
  Future<void> add(User user) async {
    _users.add(user);
  }

  @override
  Future<void> delete(User user) async {
    _users.removeWhere((element) => element == user);
  }

  @override
  Future<List<User>> get() async {
    return [..._users];
  }

  @override
  Future<void> set(List<User> users) async {}
}
