import 'package:flutter/material.dart';

/// Exclusively presentational widget that displays
/// text surrounded by some horizonthal lines.
class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider(this.text, {Key key})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildLine(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text),
        ),
        _buildLine(),
      ],
    );
  }

  Widget _buildLine() {
    return Expanded(
      child: Divider(
        thickness: 2,
        color: Colors.grey,
      ),
    );
  }
}
