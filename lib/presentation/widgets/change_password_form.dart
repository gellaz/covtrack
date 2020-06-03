import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../business/blocs/password_change/password_change_bloc.dart';
import '../../utils/app_localizations.dart';
import 'change_password_button.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  PasswordChangeBloc _passwordChangeBloc;

  bool get isPopulated =>
      _passwordController.text.isNotEmpty &&
      _passwordCheckController.text.isNotEmpty;

  bool isChangePasswordButtonEnabled(PasswordChangeState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  @override
  void initState() {
    super.initState();
    _passwordChangeBloc = context.bloc<PasswordChangeBloc>();
    _passwordController.addListener(_onPasswordChanged);
    _passwordCheckController.addListener(_onPasswordCheckChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordChangeBloc, PasswordChangeState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).changingPassword),
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
                      Text(AppLocalizations.of(context).changePasswordSuccess)),
            );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).changePasswordFailure),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<PasswordChangeBloc, PasswordChangeState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                        size: 150,
                      ),
                      Text(
                        AppLocalizations.of(context).changePasswordScreenTitle,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context).changePasswordScreenBody,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                      TextFormField(
                        autocorrect: false,
                        autovalidate: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? AppLocalizations.of(context).invalidPassword
                              : null;
                        },
                      ),
                      TextFormField(
                        autocorrect: false,
                        autovalidate: true,
                        controller: _passwordCheckController,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).insertPasswordAgain,
                        ),
                        obscureText: true,
                        validator: (_) {
                          return !state.isPasswordCheckValid
                              ? AppLocalizations.of(context).differentPasswords
                              : null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ChangePasswordButton(
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
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _passwordChangeBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onPasswordCheckChanged() {
    _passwordChangeBloc.add(
      PasswordCheckChanged(
        password: _passwordController.text,
        passwordCheck: _passwordCheckController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    print('HEYYYYY');
    _passwordChangeBloc.add(
      Submitted(
        password: _passwordController.text,
      ),
    );
  }
}
