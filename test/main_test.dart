import 'package:covtrack/screens/onboarding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:covtrack/main.dart';

void main() {
  testWidgets('Main UI test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(CovTrack());

    // The root widget contains the SplashScreen.
    expect(find.byType(Onboarding), findsOneWidget);
  });
}
