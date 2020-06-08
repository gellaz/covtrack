import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_repository.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    await currentUser.reauthenticateWithCredential(
      EmailAuthProvider.getCredential(
        email: currentUser.email,
        password: oldPassword,
      ),
    );
    return await currentUser.updatePassword(newPassword);
  }

  @override
  Future<void> deleteAccount(String password) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    await currentUser.reauthenticateWithCredential(
      EmailAuthProvider.getCredential(
        email: currentUser.email,
        password: password,
      ),
    );
    return await currentUser.delete();
  }

  @override
  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }

  @override
  Future<bool> isSignedIn() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<void> signInWithCredentials(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
