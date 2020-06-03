abstract class AuthenticationRepository {
  Future<String> getUser();
  Future<bool> isSignedIn();
  Future<void> signInWithCredentials(String email, String password);
  Future<void> signOut();
  Future<void> signUp(String email, String password);
  Future signInWithGoogle();
}
