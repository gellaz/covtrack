import 'package:covtrack/business/blocs/settings/settings_bloc.dart';
import 'package:covtrack/business/repositories/settings/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  group('SettingsBloc', () {
    SettingsRepository settingsRepository;
    SettingsBloc settingsBloc;

    setUp(() {
      settingsRepository = MockSettingsRepository();
      settingsBloc = SettingsBloc(settingsRepository: settingsRepository);
    });

    tearDown(() {
      settingsBloc?.close();
    });

    test('throws AssertionError if SettingsRepository is null', () {
      expect(
        () => SettingsBloc(settingsRepository: null),
        throwsA(isAssertionError),
      );
    });

    test('initial state is SettingsInitial', () {
      expect(settingsBloc.state, SettingsInitial());
    });

    test('close does not emit new states', () {
      expectLater(
        settingsBloc,
        emitsInOrder([SettingsInitial(), emitsDone]),
      );
      settingsBloc.close();
    });

    group('AppLoaded', () {
      final Map<String, dynamic> settings = {
        'firstRun': true,
        'theme': 'light',
      };
      blocTest(
        'emits [SettingsLoadInProgress, SettingsLoadSuccess] when no exception is raised',
        build: () async {
          when(settingsRepository.getSettings())
              .thenAnswer((_) => Future.value(settings));
          return settingsBloc;
        },
        act: (bloc) => bloc.add(AppLoaded()),
        expect: [
          SettingsLoadInProgress(),
          SettingsLoadSuccess(settings),
        ],
      );

      blocTest(
        'emits [SettingsLoadInProgress, SettingsLoadFailure] an exception is raised',
        build: () async {
          when(settingsRepository.getSettings()).thenThrow(Exception('oops'));
          return settingsBloc;
        },
        act: (bloc) => bloc.add(AppLoaded()),
        expect: [
          SettingsLoadInProgress(),
          SettingsLoadFailure(),
        ],
      );
    });

    group('SettingChanged', () {
      final Map<String, dynamic> settings = {
        'firstRun': false,
        'theme': 'dark',
      };
      blocTest(
        'emits [SettingsLoadInProgress, SettingsLoadSuccess] when no exception is raised',
        build: () async {
          when(settingsRepository.saveKV('theme', 'dark'))
              .thenAnswer((_) => Future.value(null));
          when(settingsRepository.getSettings())
              .thenAnswer((_) => Future.value(settings));
          return settingsBloc;
        },
        act: (bloc) => bloc.add(SettingChanged(key: 'theme', value: 'dark')),
        expect: [
          SettingsLoadInProgress(),
          SettingsLoadSuccess(settings),
        ],
      );

      blocTest(
        'emits [SettingsLoadInProgress, SettingsLoadFailure] an exception is raised',
        build: () async {
          when(settingsRepository.getSettings()).thenThrow(Exception('oops'));
          return settingsBloc;
        },
        act: (bloc) => bloc.add(SettingChanged(key: 'theme', value: 'dark')),
        expect: [
          SettingsLoadInProgress(),
          SettingsLoadFailure(),
        ],
      );
    });
  });
}
