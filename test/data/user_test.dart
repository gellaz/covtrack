import 'package:covtrack/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FakeFirebaseUser extends Fake implements FirebaseUser {
  final String _uid;
  final String _email;

  FakeFirebaseUser(this._uid, this._email);

  @override
  String get uid => _uid;

  @override
  String get email => _email;
}

void main() {
  final FirebaseUser fakeFirebaseUser = FakeFirebaseUser(
    'ABCDEFG123456',
    'johndoe@mail.com',
  );
  final User user1 = User(
    uid: 'ABCDEFG123456',
    email: 'johndoe@mail.com',
  );
  final User user2 = User(
    uid: 'TUVWXYZ654321',
    email: 'lisa@mail.com',
  );
  final User user3 = User(
    uid: 'ABCDEFG123456',
    email: 'johndoe@mail.com',
  );

  group('User', () {
    test('correctly generated from FirebaseUser', () {
      expect(User.fromFirebaseUser(fakeFirebaseUser), user1);
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(user1, isNot(user2));
      expect(user1, equals(user3));
    });
  });
}
