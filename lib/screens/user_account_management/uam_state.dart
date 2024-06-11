import '../../podo/department.dart';
import '../../podo/user.dart';

class UamState {
  final List<User> users;
  final List<Department> departments;

  UamState({required this.users, required this.departments});
}

class UamInitialState extends UamState {
  UamInitialState({required super.users, required super.departments});

  UamInitialState copyWith({
    List<User>? users,
    List<Department>? departments,
  }) {
    return UamInitialState(users: users ?? this.users, departments: departments ?? this.departments);
  }
}

class UamLoadingState extends UamState {
  String message;

  UamLoadingState({required super.users, required super.departments, required this.message});
  UamLoadingState copyWith({
    List<User>? users,
    List<Department>? departments,
    String? message,
  }) {
    return UamLoadingState(
        users: users ?? this.users, departments: departments ?? this.departments, message: message ?? this.message);
  }
}

class UamSuccessState extends UamState {
  String message;
  UamSuccessState({required super.users, required super.departments, required this.message});
  UamSuccessState copyWith({
    List<User>? users,
    List<Department>? departments,
    String? message,
  }) {
    return UamSuccessState(
        users: users ?? this.users, departments: departments ?? this.departments, message: message ?? this.message);
  }
}

class UamErrorState extends UamState {
  String error;
  UamErrorState({required super.users, required super.departments, required this.error});
  UamErrorState copyWith({
    List<User>? users,
    List<Department>? departments,
    String? error,
  }) {
    return UamErrorState(
        users: users ?? this.users, departments: departments ?? this.departments, error: error ?? this.error);
  }
}
