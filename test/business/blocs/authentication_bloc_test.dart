import 'package:covtrack/business/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationBloc', () {
    test('throws AssertionError if WeatherRepository is null', () {
      expect(
        () => AuthenticationBloc(authRepository: null),
        throwsA(isAssertionError),
      );
    });
  });
}
