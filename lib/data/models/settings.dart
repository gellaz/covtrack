import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Settings extends Equatable {
  final int settingsId;
  final bool firstRun;
  final String theme;

  Settings({
    this.settingsId,
    @required this.firstRun,
    @required this.theme,
  });

  factory Settings.init() {
    return Settings(
      firstRun: true,
      theme: 'light',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'settingsId': settingsId,
      'firstRun': firstRun,
      'theme': theme,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      settingsId: map['settingsId'],
      firstRun: map['firstRun'],
      theme: map['theme'],
    );
  }

  Settings copyWith({
    int settingsId,
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
