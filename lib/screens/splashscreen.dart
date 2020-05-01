import 'dart:ui';

import 'package:flutter/material.dart';

import '../themes/decorations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: Decorations.linearGradient(context: context),
          child: Column(
            children: <Widget>[
              Text(
                'COVTRACK',
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/images/home.png')
            ],
          ),
        ),
      ),
    );
  }
}
