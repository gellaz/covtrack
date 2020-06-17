import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String uid;
  final String email;

  const User({
    @required this.uid,
    @required this.email,
  });

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
