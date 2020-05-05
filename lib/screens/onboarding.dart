import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../styles/decorations.dart';
import 'wrappers/authentication_wrapper.dart';

/// This widget is used to intorduce the user to the application if
/// it is the first time he launches it.
class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        _buildPageOne(context),
        _buildPageTwo(context),
        _buildPageThree(context),
      ],
      onDone: () => _onDone(context),
      done: const Text('Done'),
      showSkipButton: true,
      skip: const Text('Skip'),
    );
  }

  void _onDone(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AuthenticationWrapper(),
      ),
    );
  }

  // First page of the onboarding.
  PageViewModel _buildPageOne(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Image.asset('assets/images/home.png'),
      ),
      title: 'Stay Safe and get ready for change',
      body: 'AAAAAAAAA',
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context: context),
      ),
    );
  }

  // Second page of the onboarding.
  PageViewModel _buildPageTwo(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Image.asset('assets/images/home.png'),
      ),
      title: 'Stay Home',
      body: 'AAAAAAAAA',
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context: context),
      ),
    );
  }

  // Third page of the onboarding.
  PageViewModel _buildPageThree(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Image.asset('assets/images/home.png'),
      ),
      title: 'Stay Home',
      body: 'AAAAAAAAA',
      decoration: PageDecoration(
        boxDecoration: Decorations.linearGradient(context: context),
      ),
    );
  }
}
