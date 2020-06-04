abstract class AuthenticationRepository {
  Future changePassword(String oldPassword, String newPassword);
  Future deleteAccount(String password);
  Future getUser();
  Future isSignedIn();
  Future signInWithCredentials(String email, String password);
  Future signInWithGoogle();
  Future signOut();
  Future signUp(String email, String password);
}
