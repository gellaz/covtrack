import 'package:covtrack/business/blocs/settings/settings_bloc.dart';
import 'package:covtrack/business/repositories/settings/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  SettingsRepository settingsRepository;
  SettingsBloc settingsBloc;

  group('SettingsBloc', () {
    setUp(() {
      settingsRepository = MockSettingsRepository();
      settingsBloc = SettingsBloc(settingsRepository: settingsRepository);
    });

    test('throws AssertionError if SettingsRepository is null', () {
      expect(
        () => SettingsBloc(settingsRepository: null),
        throwsA(isAssertionError),
      );
    });
    test('initial state is SettingsInitial', () {
      expect(settingsBloc.initialState, SettingsInitial());
    });
  });
}
