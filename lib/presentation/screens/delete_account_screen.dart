import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/delete_account/delete_account_bloc.dart';
import '../../business/repositories/authentication/authentication_repository.dart';
import '../../utils/app_localizations.dart';
import '../widgets/delete_account_form.dart';

class DeleteAccountScreen extends StatelessWidget {
  static const routeName = '/delete-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).deleteAccount)),
      body: BlocProvider(
        create: (context) => DeleteAccountBloc(
          context.repository<AuthenticationRepository>(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: DeleteAccountForm(),
        ),
      ),
    );
  }
}
