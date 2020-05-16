import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Settings extends Equatable {
  final String settingsId;
  final bool firstRun;
  final String theme;

  Settings({
    @required this.settingsId,
    @required this.firstRun,
    @required this.theme,
  });

  Settings copyWith({
    String tripId,
    bool firstRun,
    String theme,
  }) {
    return Settings(
      settingsId: settingsId ?? this.settingsId,
      firstRun: firstRun ?? this.firstRun,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object> get props => [
        settingsId,
        firstRun,
        theme,
      ];

  @override
  String toString() {
    return '''
    Settings {
      settingsId: $settingsId,
      firstRun: $firstRun,
      theme: $theme,
    }''';
  }
}
