import 'package:flutter_bloc/flutter_bloc.dart';

import '../../podo/user.dart';
import '../../repositories/cache_repositories/department_cache_repository.dart';
import '../../repositories/cache_repositories/user_cache_repository.dart';
import '../../repositories/network_repositories/department_network_repository.dart';
import '../../repositories/network_repositories/user_network_repository.dart';
import 'uam_state.dart';

class UamCubit extends Cubit<UamState> {
  final int year;
  final repository = UserNetworkRepository();
  final cacheRepository = UserCacheRepository();
  final departmentRepository = DepartmentNetworkRepository();
  final departmentCacheRepository = DepartmentCacheRepository();

  UamCubit({required this.year}) : super(UamInitialState(users: [], departments: [])) {
    fetchUsers();
    fetchDepartments();
  }

  Future<void> fetchUsers() async {
    _fetchLocal();
    _fetchRemote();
  }

  Future<void> fetchDepartments() async {
    emit(UamLoadingState(
        users: state.users, departments: state.departments, message: "Fetching departments from network"));
    try {
      final departments = await departmentRepository.get(year);
      if (!isClosed) {
        emit(UamSuccessState(users: state.users, departments: departments, message: "Departments data loaded"));
      }
    } catch (err) {
      emit(UamErrorState(users: [], departments: state.departments, error: err.toString()));
    }
  }

  Future<void> _fetchLocal() async {
    emit(UamLoadingState(users: state.users, departments: state.departments, message: 'Fetching users from cache'));
    try {
      final users = await cacheRepository.get();
      if (!isClosed) emit(UamSuccessState(users: users, departments: state.departments, message: "Users data loaded"));
    } catch (err) {
      emit(UamErrorState(users: [], departments: state.departments, error: err.toString()));
    }
  }

  Future<void> _fetchRemote() async {
    emit(UamLoadingState(users: state.users, departments: state.departments, message: "Fetching users from network"));
    try {
      final users = await repository.get();
      cacheNetworkResult(users);
      if (!isClosed) emit(UamSuccessState(users: users, departments: state.departments, message: "Users data loaded"));
    } catch (err) {
      emit(UamErrorState(users: [], departments: state.departments, error: err.toString()));
    }
  }

  Future<void> addUser(User user) async {
    emit(UamLoadingState(users: state.users, departments: state.departments, message: "Creating user..."));
    try {
      await repository.add(user);
      fetchUsers();
      emit(UamSuccessState(users: state.users, departments: state.departments, message: "User Successfully Created"));
    } catch (err) {
      emit(UamErrorState(users: state.users, departments: state.departments, error: err.toString()));
    }
  }

  Future<void> deleteUser(User user) async {
    emit(UamLoadingState(users: state.users, departments: state.departments, message: "Deleting user..."));
    try {
      await repository.delete(user);
      fetchUsers();
      emit(UamSuccessState(users: state.users, departments: state.departments, message: "User Successfully Deleted"));
    } catch (err) {
      emit(UamErrorState(users: state.users, departments: state.departments, error: err.toString()));
    }
  }

  void cacheNetworkResult(List<User> users) {
    cacheRepository.set(users);
  }

  void reset() {
    emit(UamInitialState(users: state.users, departments: state.departments));
  }
}
