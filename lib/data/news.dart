import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Class representing news fetched from the Covid-19 API. The news collected
/// can be divided into two groups: local (news regarding the country of the user)
/// and global (news regarding the whole world).
class News extends Equatable {
  /// Date on which the data was collected.
  final DateTime date;

  /// Total number of people infected with the Covid-19 virus.
  final int confirmed;

  /// Total number of people killed by Covid-19 virus.
  final int deaths;

  /// Total number of people cured of the Covid-19 virus.
  final int recovered;

  const News({
    @required this.date,
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
  });

  /// Deserializes the input [json] object into a local [News] object.
  factory News.fromJsonLocal(Map<String, dynamic> json, String dateString) {
    return News(
      date: DateTime.parse(dateString),
      confirmed: json['result'][dateString]['confirmed'],
      deaths: json['result'][dateString]['deaths'],
      recovered: json['result'][dateString]['recovered'],
    );
  }

  /// Deserializes the input [json] object into a global [News] object.
  factory News.fromJsonGlobal(Map<String, dynamic> json) {
    return News(
      date: DateTime.parse(json['date']),
      confirmed: json['result']['confirmed'],
      deaths: json['result']['deaths'],
      recovered: json['result']['recovered'],
    );
  }

  /// Returns a copy of the [News] object where only the properties
  /// passed in as arguments are updated.
  News copyWith({
    DateTime date,
    int confirmed,
    int deaths,
    int recovered,
  }) {
    return News(
      date: date ?? this.date,
      confirmed: confirmed ?? this.confirmed,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
    );
  }

  @override
  List<Object> get props => [
        date,
        confirmed,
        deaths,
        recovered,
      ];

  @override
  String toString() {
    return '''
    News {
      date: $date,
      confirmed: $confirmed,
      deaths: $deaths,
      recovered: $recovered,
    }
    ''';
  }
}
