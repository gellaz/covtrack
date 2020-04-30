import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
      onDone: () {},
      done: const Text('Done'),
      showSkipButton: true,
      skip: const Text('Skip'),
    );
  }

  // First page of the onboarding.
  PageViewModel _buildPageOne(BuildContext context) {
    return PageViewModel(
      image: Center(
        child: Image.asset('assets/images/home.png'),
      ),
      title: 'Stay Home',
      body: 'AAAAAAAAA',
      decoration: PageDecoration(
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
          ),
        ),
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
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
          ),
        ),
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
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }
}
