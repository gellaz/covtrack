import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../business/blocs/settings/settings_bloc.dart';
import '../../utils/app_localizations.dart';
import '../styles/decorations.dart';
import 'authentication_screen.dart';

/// This widget is used to introduce the user to the application on the first run.
class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        _buildPageOne(context),
        _buildPageTwo(context),
        _buildPageThree(context),
        _buildPageFour(context),
      ],
      onDone: () => _onDone(context),
      done: Text(AppLocalizations.of(context).done),
      showSkipButton: true,
      skip: Text(AppLocalizations.of(context).skip),
    );
  }

  void _onDone(BuildContext context) {
    // Changing the `firstRun` setting so that the next time the application
    // is launched, the onboarding will no longer be displayed.
    context.bloc<SettingsBloc>()..add(SettingChanged('firstRun', false));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AuthenticationScreen(),
      ),
    );
  }

  // First page of the onboarding.
  PageViewModel _buildPageOne(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Icon(Icons.library_books, size: 150),
      ),
      title: AppLocalizations.of(context).objective,
      body: AppLocalizations.of(context).onboarding1,
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context),
      ),
    );
  }

  // Second page of the onboarding.
  PageViewModel _buildPageTwo(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Icon(Icons.home, size: 150),
      ),
      title: AppLocalizations.of(context).home,
      body: AppLocalizations.of(context).onboarding2,
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context),
      ),
    );
  }

  // Third page of the onboarding.
  PageViewModel _buildPageThree(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Icon(Icons.info_outline, size: 150),
      ),
      title: AppLocalizations.of(context).info,
      body: AppLocalizations.of(context).onboarding3,
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context),
      ),
    );
  }

  // Fourth page of the onboarding.
  PageViewModel _buildPageFour(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Icon(Icons.settings, size: 150),
      ),
      title: AppLocalizations.of(context).settings,
      body: AppLocalizations.of(context).onboarding4,
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context),
      ),
    );
  }
}
