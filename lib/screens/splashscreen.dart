import 'dart:ui';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Colors.white,
              ],
            ),
          ),
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
