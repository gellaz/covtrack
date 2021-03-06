import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../data/user.dart';
import 'authentication_repository.dart';

/// Implementation of the [AuthenticationRepository] interface that uses
/// Firebase as the authentication service provider.
class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> changePassword({
    @required String currentPassword,
    @required String newPassword,
  }) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    await reauthenticate(password: currentPassword);
    return await currentUser.updatePassword(newPassword);
  }

  @override
  Future<void> deleteAccount({
    @required String email,
    @required String password,
  }) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    await reauthenticate(password: password);
    return await currentUser.delete();
  }

  @override
  Future<User> getUser() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(currentUser);
  }

  @override
  Future<bool> isSignedIn() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<void> reauthenticate({
    @required String password,
  }) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    await currentUser.reauthenticateWithCredential(
      EmailAuthProvider.getCredential(
        email: currentUser.email,
        password: password,
      ),
    );
    return await currentUser.reload();
  }

  @override
  Future<void> signInWithCredentials({
    @required String email,
    @required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(currentUser);
  }

  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
