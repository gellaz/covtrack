abstract class AuthenticationRepository {
  Future<String> getUserId();
  Future<bool> isSignedIn();
  Future<void> signInWithCredentials(String email, String password);
  Future<void> signOut();
  Future<void> signUp(String email, String password);
}
