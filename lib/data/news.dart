import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class News extends Equatable {
  final DateTime date;
  final int confirmed;
  final int deaths;
  final int recovered;

  News({
    @required this.date,
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
  });

  factory News.fromJsonLocal(Map<String, dynamic> json, String dateString) {
    return News(
      date: DateTime.parse(dateString),
      confirmed: json['result'][dateString]['confirmed'],
      deaths: json['result'][dateString]['deaths'],
      recovered: json['result'][dateString]['recovered'],
    );
  }

  factory News.fromJsonGlobal(Map<String, dynamic> json) {
    return News(
      date: DateTime.parse(json['date']),
      confirmed: json['result']['confirmed'],
      deaths: json['result']['deaths'],
      recovered: json['result']['recovered'],
    );
  }

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
