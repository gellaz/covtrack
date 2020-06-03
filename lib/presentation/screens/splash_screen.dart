import 'dart:ui';

import 'package:flutter/material.dart';

import '../styles/decorations.dart';

/// Splash screen of CovTrack application
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Decorations.linearGradient(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'COVTRACK',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(letterSpacing: 6, fontWeight: FontWeight.w600),
            ),
            Icon(Icons.home, size: 150),
            Text('from'),
            Text('MARCO GELLI')
          ],
        ),
      ),
    );
  }
}