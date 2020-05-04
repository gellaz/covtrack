import 'dart:ui';

import 'package:flutter/material.dart';

import '../styles/decorations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Decorations.linearGradient(context: context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'COVTRACK',
              style: Theme.of(context)
                  .textTheme
                  .display2
                  .copyWith(letterSpacing: 6, fontWeight: FontWeight.w600),
            ),
            Image.asset('assets/images/home.png'),
            Text('Caio')
          ],
        ),
      ),
    );
  }
}
