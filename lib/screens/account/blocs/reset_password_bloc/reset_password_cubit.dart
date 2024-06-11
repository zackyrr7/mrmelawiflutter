import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exceptions/network_exception.dart';
import '../../../../repositories/network_repositories/account_network_repository.dart';
import '../../widgets/reset_password_data.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(super.initialState);

  Future<void> resetPassword({required ResetPasswordData resetPasswordData}) async {
    try {
      emit(ResettingPasswordState());
      final repository = AccountNetworkRepository();
      await repository.resetPassword(
        oldPassword: resetPasswordData.oldPassword,
        newPassword: resetPasswordData.newPassword,
      );
      emit(SuccessResetPasswordState(message: "Successfully reset your account password"));
    } on NetworkException catch (error) {
      emit(ErrorResetPasswordState(errorMessage: error.errorMessage));
    } catch (_) {
      emit(ErrorResetPasswordState(errorMessage: "Unable to reset your password"));
    }
  }

  Future<void> reset() async {
    emit(ResetPasswordInitialState());
  }
}
