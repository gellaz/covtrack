import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../business/blocs/register/register_bloc.dart';
import '../../utils/app_localizations.dart';
import '../styles/decorations.dart';
import '../widgets/text_divider.dart';
import 'login_link.dart';
import 'register_button.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _passwordCheckController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  @override
  void initState() {
    super.initState();
    _registerBloc = context.bloc<RegisterBloc>();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _passwordCheckController.addListener(_onPasswordCheckChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).registering),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          context.bloc<AuthenticationBloc>().add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).registrationFailure,
                    ),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Container(
        decoration: Decorations.linearGradient(context),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).register.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 8,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.person_add,
                            size: 200,
                          ),
                          TextFormField(
                            autocorrect: false,
                            autovalidate: true,
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (_) =>
                                FocusScope.of(context).nextFocus(),
                            textInputAction: TextInputAction.next,
                            validator: (_) {
                              return !state.isEmailValid
                                  ? AppLocalizations.of(context).invalidEmail
                                  : null;
                            },
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
                              labelText: AppLocalizations.of(context)
                                  .insertPasswordAgain,
                            ),
                            obscureText: true,
                            validator: (_) {
                              return !state.isPasswordCheckValid
                                  ? AppLocalizations.of(context)
                                      .differentPasswords
                                  : null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                RegisterButton(
                                  onPressed: isRegisterButtonEnabled(state)
                                      ? _onFormSubmitted
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        TextDivider(
                          AppLocalizations.of(context).or,
                        ),
                        SizedBox(height: 8),
                        LoginLink(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onPasswordCheckChanged() {
    _registerBloc.add(
      PasswordCheckChanged(
        password: _passwordController.text,
        passwordCheck: _passwordCheckController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
