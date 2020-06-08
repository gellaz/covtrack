import 'package:covtrack/business/blocs/trips/trips_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../business/blocs/delete_account/delete_account_bloc.dart';
import '../../utils/app_localizations.dart';
import 'delete_account_button.dart';
import 'delete_account_dialog.dart';

class DeleteAccountForm extends StatefulWidget {
  @override
  _DeleteAccountFormState createState() => _DeleteAccountFormState();
}

class _DeleteAccountFormState extends State<DeleteAccountForm> {
  final _passwordController = TextEditingController();
  DeleteAccountBloc _deleteAccountBloc;

  bool get isPopulated => _passwordController.text.isNotEmpty;

  bool isChangePasswordButtonEnabled(DeleteAccountState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  @override
  void initState() {
    super.initState();
    _deleteAccountBloc = context.bloc<DeleteAccountBloc>();
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).deletingAccount),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          context.bloc<AuthenticationBloc>().add(LoggedOut());
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    Text(AppLocalizations.of(context).deleteAccountSuccess),
              ),
            );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).deleteAccountFailure),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        return Form(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                        FontAwesomeIcons.userAltSlash,
                        color: Theme.of(context).primaryColor,
                        size: 120,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).deleteAccountScreenTitle,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context).deleteAccountScreenBody,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      autovalidate: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? AppLocalizations.of(context).invalidPassword
                            : null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          DeleteAccountButton(
                            onPressed: isChangePasswordButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _deleteAccountBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: context.bloc<TripsBloc>(),
        child: DeleteAccountDialog(
          deleteAccountBloc: _deleteAccountBloc,
          password: _passwordController.text,
        ),
      ),
    );
  }
}
