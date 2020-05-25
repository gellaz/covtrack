import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../utils/app_localizations.dart';
import '../containers/authentication_container.dart';
import '../styles/decorations.dart';

/// This widget is used to intorduce the user to the application if
/// it is the first time he launches it.
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AuthenticationContainer(),
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

  // First page of the onboarding.
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

  // Second page of the onboarding.
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

  // Third page of the onboarding.
  PageViewModel _buildPageFour(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Icon(Icons.favorite, size: 150),
      ),
      title: AppLocalizations.of(context).donate,
      body: AppLocalizations.of(context).onboarding4,
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context),
      ),
    );
  }
}
