import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';

class User extends Equatable {
  final String uid;
  final Place home;

  const User({
    @required this.uid,
    @required this.home,
  });

  @override
  List<Object> get props => [uid, home];

  @override
  String toString() {
    return '''
    User {
      uid: $uid,
      home: $home,
    }''';
  }
}
