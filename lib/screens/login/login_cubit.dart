import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final session = await AuthService.instance.login(email: email, password: password);
      emit(LoginSuccess(session));
    } catch (err) {
      emit(LoginError(err.toString()));
    }
  }

  void setInitial() {
    emit(LoginInitial());
  }
}
