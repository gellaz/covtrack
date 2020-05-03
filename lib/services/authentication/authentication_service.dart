import 'package:covtrack/models/user.dart';

abstract class AuthenticationService {
  Future<User> getUser();
  Future<bool> isSignedIn();
  Future<void> signInWithCredentials({String email, String password});
  Future<void> signOut();
  Future<void> signUp({String email, String password});
}
