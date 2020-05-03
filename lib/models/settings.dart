import 'package:meta/meta.dart';

class Settings {
  final bool firstRun;
  String theme;

  static final _instance = Settings._internal(
    firstRun: false,
    theme: 'light',
  );

  Settings._internal({
    @required this.firstRun,
    @required this.theme,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstRun': this.firstRun,
      'theme': this.theme,
    };
  }

  void updateFromMap({@required Map<String, dynamic> settingsMap}) {
    Settings._internal(
      firstRun: settingsMap['firstRun'] ?? this.firstRun,
      theme: settingsMap['theme'] ?? this.theme,
    );
  }

  factory Settings() => _instance;

  @override
  String toString() {
    return 'Settings { theme: $theme }';
  }
}
