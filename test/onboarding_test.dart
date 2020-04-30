import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:covtrack/screens/onboarding.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  var app = MaterialApp(
    home: Scaffold(
      body: Onboarding(),
    ),
  );

  testWidgets('OnboardingScreen UI test', (WidgetTester tester) async {
    // Pump Onboarding widget to test.
    await tester.pumpWidget(app);

    // We expect to find only one IntroductionScreen widget.
    expect(find.byType(IntroductionScreen), findsOneWidget);
  });
}
