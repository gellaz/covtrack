import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/settings/settings_bloc.dart';
import '../../utils/app_localizations.dart';

/// Container class that builds different types of UIs depending
/// on the state of [SettingsBloc].
class ChangeThemeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoadFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).settingsFailure),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
      },
      builder: (_, state) {
        if (state is SettingsLoadInProgress) {
          return LoadInProgressDialog();
        }
        if (state is SettingsLoadSuccess) {
          return LoadSuccessDialog(currentTheme: state.settings['theme']);
        }
        return Container();
      },
    );
  }
}

/// Dialog displayed when the application settings are loading.
class LoadInProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(content: CircularProgressIndicator());
  }
}

/// Private enumeration containing the selectable app themes.
enum _Theme { light, dark }

/// Dialog displayed when the application settings are successfully loaded
/// that lets the user set the app theme using radio controls.
class LoadSuccessDialog extends StatefulWidget {
  final String currentTheme;

  const LoadSuccessDialog({Key key, this.currentTheme}) : super(key: key);

  @override
  _LoadSuccessDialogState createState() => _LoadSuccessDialogState();
}

class _LoadSuccessDialogState extends State<LoadSuccessDialog> {
  /// SettingsBloc used to dispatch events.
  SettingsBloc _settingsBloc;

  /// Selected theme.
  _Theme _theme;

  @override
  void initState() {
    super.initState();
    _settingsBloc = context.bloc<SettingsBloc>();
    _theme = widget.currentTheme == 'light' ? _Theme.light : _Theme.dark;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).changeThemeDialogTitle),
      content: Text(AppLocalizations.of(context).changeThemeDialogContent),
      actions: <Widget>[
        _buildContainer(_Theme.light, 'Light'),
        _buildContainer(_Theme.dark, 'Dark'),
      ],
    );
  }

  Container _buildContainer(_Theme value, String label) {
    return Container(
      width: 150,
      child: RadioListTile<_Theme>(
        title: Text(label),
        value: value,
        groupValue: _theme,
        onChanged: (_Theme value) {
          setState(() {
            _theme = value;
          });

          // If value is _Theme.light selectedTheme = 'light', else
          // if value is _Theme.dark selectedTheme = 'dark.
          String selectedTheme = value.toString().split('.').last;

          // Dispatching SettingChanged event to the SettingsBloc with
          // the key value pair containing the selected theme.
          _settingsBloc.add(SettingChanged(key: 'theme', value: selectedTheme));

          // Closes the AlertDialog.
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
