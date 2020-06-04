import 'dart:ui';

import 'package:flutter/material.dart';

import '../styles/decorations.dart';

/// Splash screen of the application
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Decorations.linearGradient(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'COVTRACK',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(letterSpacing: 6, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                const Icon(Icons.home, size: 150),
                SizedBox(height: 50),
                Spacer(),
                Column(
                  children: <Widget>[
                    const Text('from'),
                    Text(
                      'MARCO GELLI',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          letterSpacing: 3, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
