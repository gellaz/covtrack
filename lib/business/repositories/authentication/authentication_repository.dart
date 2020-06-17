/// Contract that all implementations of [AuthenticationRepository] interface must follow.
abstract class AuthenticationRepository {
  /// Changes a registered user's [currentPassword] to [newPassword].
  Future changePassword({String currentPassword, String newPassword});

  /// Deletes the user account currently logged in.
  /// The [password] is necessary as a security measure.
  Future deleteAccount({String password});

  /// Retrieve the information of the user currently logged in.
  Future getUser();

  /// Checks if a user is already authenticated.
  Future isSignedIn();

  /// Allows users to sign in with their own [email] and [password] credentials.
  Future signInWithCredentials({String email, String password});

  /// Allows users to sign in using their Google accounts.
  Future signInWithGoogle();

  /// Logouts the user and clear his profile information from the device.
  Future signOut();

  /// Allows users to create an account with [email] and [password]
  /// combination if they choose not to use Google Sign In.
  Future signUp({String email, String password});
}
