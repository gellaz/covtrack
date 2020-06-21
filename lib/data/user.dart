import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

/// Entity representing the user of the application.
class User extends Equatable {
  /// Unique identifier for the user within the system.
  final String uid;

  /// Email with which the user has registered.
  final String email;

  const User({
    @required this.uid,
    @required this.email,
  });

  /// Utility method to convert a FirebaseUser into a [User] object.
  factory User.fromFirebaseUser(FirebaseUser firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
    );
  }

  @override
  List<Object> get props => [
        uid,
        email,
      ];

  @override
  String toString() {
    return '''
    User {
      uid: $uid,
      email: $email,
    }''';
  }
}
