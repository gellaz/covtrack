import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/change_password/change_password_bloc.dart';
import '../../business/repositories/authentication/authentication_repository.dart';
import '../../utils/app_localizations.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).changePassword)),
      body: BlocProvider(
        create: (context) => ChangePasswordBloc(
          authRepository: context.repository<AuthenticationRepository>(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: ChangePasswordForm(),
        ),
      ),
    );
  }
}
