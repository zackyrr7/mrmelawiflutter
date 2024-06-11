import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/auth_service.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  Future<void> logout() async {
    emit(AccountLoading());
    try {
      await AuthService.instance.logout();
      emit(AccountSuccess());
    } catch (err) {
      emit(AccountError());
    }
  }
}
