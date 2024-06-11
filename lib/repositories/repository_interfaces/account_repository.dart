abstract class AccountRepository {
  Future<void> resetPassword({required String oldPassword, required String newPassword});
}
