import 'package:flutter/material.dart';

enum Theme { light, dark }

class ThemeSelector extends StatefulWidget {
  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  Theme _theme = Theme.light;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.color_lens),
              SizedBox(width: 10),
              Text('Theme'),
            ],
          ),
          Expanded(
            child: ListView(
              children: Theme.values.map((t) {
                return ListTile(
                  title: Text(t.toString().split('.').last),
                  leading: Radio(
                    value: t,
                    groupValue: _theme,
                    onChanged: (Theme value) {
                      setState(() {
                        _theme = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
