import 'package:firebase_auth/firebase_auth.dart';

part 'firebase_authentication_service.dart';

abstract class AuthenticationService {
  Future<String> getUserId();
  Future<bool> isSignedIn();
  Future<void> signInWithCredentials({String email, String password});
  Future<void> signOut();
  Future<void> signUp({String email, String password});
}
