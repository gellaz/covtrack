import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  final VoidCallback onClear;

  const ClearButton(this.onClear, {Key key})
      : assert(onClear != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.clear),
      onPressed: onClear,
    );
  }
}
