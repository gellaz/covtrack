import 'package:flutter/material.dart';

class Decorations {
  static BoxDecoration linearGradient(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).primaryColor,
          Colors.white,
        ],
      ),
    );
  }
}
