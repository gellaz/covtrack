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
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordCheckController = TextEditingController();
  PasswordChangeBloc _passwordChangeBloc;

  bool get isPopulated =>
      _oldPasswordController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _newPasswordCheckController.text.isNotEmpty;

  bool isChangePasswordButtonEnabled(PasswordChangeState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  @override
  void initState() {
    super.initState();
    _passwordChangeBloc = context.bloc<PasswordChangeBloc>();
    _oldPasswordController.addListener(_onOldPasswordChanged);
    _newPasswordController.addListener(_onNewPasswordChanged);
    _newPasswordCheckController.addListener(_onNewPasswordCheckChanged);
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
                content: Text(
                  AppLocalizations.of(context).changePasswordSuccess,
                ),
              ),
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
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context).changePasswordScreenBody,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        autovalidate: true,
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).oldPassword,
                        ),
                        obscureText: true,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        validator: (_) {
                          return !state.isOldPasswordValid
                              ? AppLocalizations.of(context).invalidPassword
                              : null;
                        },
                      ),
                      TextFormField(
                        autocorrect: false,
                        autovalidate: true,
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).newPassword,
                        ),
                        obscureText: true,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        validator: (_) {
                          return !state.isNewPasswordValid
                              ? AppLocalizations.of(context).invalidPassword
                              : null;
                        },
                      ),
                      TextFormField(
                        autocorrect: false,
                        autovalidate: true,
                        controller: _newPasswordCheckController,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).insertPasswordAgain,
                        ),
                        obscureText: true,
                        validator: (_) {
                          return !state.isNewPasswordCheckValid
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
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordCheckController.dispose();
    super.dispose();
  }

  void _onOldPasswordChanged() {
    _passwordChangeBloc.add(
      OldPasswordChanged(password: _oldPasswordController.text),
    );
  }

  void _onNewPasswordChanged() {
    _passwordChangeBloc.add(
      NewPasswordChanged(password: _newPasswordController.text),
    );
  }

  void _onNewPasswordCheckChanged() {
    _passwordChangeBloc.add(
      NewPasswordCheckChanged(
        password: _newPasswordController.text,
        passwordCheck: _newPasswordCheckController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _passwordChangeBloc.add(
      Submitted(
        oldPassword: _oldPasswordController.text,
        newPassowrd: _newPasswordController.text,
      ),
    );
  }
}