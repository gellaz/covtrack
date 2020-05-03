import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String uid;

  const User({@required this.uid});

  @override
  List<Object> get props => [uid];
}
