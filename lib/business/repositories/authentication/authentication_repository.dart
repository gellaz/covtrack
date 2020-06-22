import 'package:meta/meta.dart';

import '../../../data/user.dart';

/// Contract that all implementations of [AuthenticationRepository] interface must follow.
/// Exposes all the necessary methods to manage authentication and account management operations.
abstract class AuthenticationRepository {
  /// Changes a registered user's [currentPassword] to [newPassword].
  Future<void> changePassword({
    @required String currentPassword,
    @required String newPassword,
  });

  /// Deletes the user account currently logged in.
  /// The [password] is necessary as a security measure.
  Future<void> deleteAccount({
    @required String password,
  });

  /// Returns a [User] object containing all the information
  /// of the user currently logged in.
  Future<User> getUser();

  /// Checks if a user is already authenticated.
  Future<bool> isSignedIn();

  /// Reauthenticates the user with his credentials.
  Future<void> reauthenticate({
    @required String password,
  });

  /// Allows users to sign in with their own [email] and [password] credentials.
  Future<void> signInWithCredentials({
    @required String email,
    @required String password,
  });

  /// Allows users to sign in using their Google accounts. If successfull
  /// returns a [User] object representing the user currently logged in.
  Future<User> signInWithGoogle();

  /// Logouts the user and clear his profile information from the device.
  Future<void> signOut();

  /// Allows users to create an account with [email] and [password]
  /// combination if they choose not to use Google Sign In.
  Future<void> signUp({
    @required String email,
    @required String password,
  });
}
