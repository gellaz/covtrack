import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business/blocs/settings/settings_bloc.dart';
import '../styles/decorations.dart';
import 'authentication_screen.dart';
import 'onboarding_screen.dart';

/// Splash screen of the application
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocBuilder<SettingsBloc, SettingsState>(
            builder: (_, state) {
              if (state is SettingsLoadSuccess) {
                return state.settings['firstRun']
                    ? OnboardingScreen()
                    : AuthenticationScreen();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

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
                const Spacer(),
                const Icon(FontAwesomeIcons.virus, size: 150),
                const SizedBox(height: 50),
                const Spacer(),
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
