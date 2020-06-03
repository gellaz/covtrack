import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

enum _Theme { light, dark }

class ChangeThemeDialog extends StatefulWidget {
  @override
  _ChangeThemeDialogState createState() => _ChangeThemeDialogState();
}

class _ChangeThemeDialogState extends State<ChangeThemeDialog> {
  _Theme _theme = _Theme.light;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).changeThemeDialogTitle),
      content: Text(AppLocalizations.of(context).changeThemeDialogContent),
      actions: <Widget>[
        RadioListTile<_Theme>(
          title: const Text('Light'),
          value: _Theme.light,
          groupValue: _theme,
          onChanged: (_Theme value) {
            setState(() {
              _theme = value;
            });
          },
        ),
        RadioListTile<_Theme>(
          title: const Text('Dark'),
          value: _Theme.dark,
          groupValue: _theme,
          onChanged: (_Theme value) {
            setState(() {
              _theme = value;
            });
          },
        ),
      ],
    );
  }
}
