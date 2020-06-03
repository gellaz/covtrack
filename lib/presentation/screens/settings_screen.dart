import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../utils/app_localizations.dart';
import '../widgets/logout_button.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).settings),
            actions: <Widget>[LogoutButton()],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: state is Authenticated
                        ? Text(state.email)
                        : CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.color_lens,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(AppLocalizations.of(context).changeTheme),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      _buildContainer(),
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        title:
                            Text(AppLocalizations.of(context).changePassword),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ChangePasswordScreen.routeName);
                        },
                      ),
                      _buildContainer(),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.userAltSlash,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(AppLocalizations.of(context).deleteAccount),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}
