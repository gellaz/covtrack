import 'package:flutter/material.dart';

import '../../repositories/user_repository.dart';
import '../register/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository userRepository;

  CreateAccountButton({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: userRepository);
          }),
        );
      },
    );
  }
}
