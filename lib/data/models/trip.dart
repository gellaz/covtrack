import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sembast/timestamp.dart';

import 'place.dart';

class Trip extends Equatable {
  final int tripId;
  final String reason;
  final DateTime startingTime;
  final DateTime arrivalTime;
  final Place source;
  final Place destination;

  Trip({
    this.tripId,
    @required this.reason,
    @required this.startingTime,
    @required this.arrivalTime,
    @required this.source,
    @required this.destination,
  });

  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'reason': reason,
      'startingTime': Timestamp.fromDateTime(startingTime),
      'arrivalTime':
          arrivalTime != null ? Timestamp.fromDateTime(arrivalTime) : null,
      'source': source.toMap(),
      'destination': destination.toMap(),
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      tripId: map['tripId'],
      reason: map['reason'],
      startingTime: (map['startingTime'] as Timestamp).toDateTime(),
      arrivalTime: (map['arrivalTime'] as Timestamp)?.toDateTime(),
      source: Place.fromMap(map['source']),
      destination: Place.fromMap(map['destination']),
    );
  }

  Trip copyWith({
    int tripId,
    String reason,
    DateTime startingTime,
    DateTime arrivalTime,
    Place source,
    Place destination,
  }) {
    return Trip(
      tripId: tripId ?? this.tripId,
      reason: reason ?? this.reason,
      startingTime: startingTime ?? this.startingTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      source: source ?? this.source,
      destination: destination ?? this.destination,
    );
  }

  @override
  List<Object> get props => [
        tripId,
        reason,
        startingTime,
        arrivalTime,
        source,
        destination,
      ];

  @override
  String toString() {
    return '''
    Trip {
      tripId: $tripId,
      reason: $reason,
      startingTime: $startingTime,
      arrivalTime: $arrivalTime,
      source: $source,
      destination: $destination,
    }''';
  }
}
