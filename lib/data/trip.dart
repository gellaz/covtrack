import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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
  final List<Position> stops;

  Trip({
    @required this.tripId,
    @required this.reason,
    @required this.startingTime,
    @required this.arrivalTime,
    @required this.source,
    @required this.destination,
    @required this.stops,
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
      'stops': this.stops != null
          ? this.stops.map((pos) => pos.toJson()).toList()
          : null,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    var myStops;
    if (map['stops'] != null) {
      myStops = List<Position>();
      map['stops'].forEach((v) {
        myStops.add(Position.fromMap(v));
      });
    }
    return Trip(
      tripId: map['tripId'],
      reason: map['reason'],
      startingTime: (map['startingTime'] as Timestamp)?.toDateTime(),
      arrivalTime: (map['arrivalTime'] as Timestamp)?.toDateTime(),
      source: Place.fromMap(map['source']),
      destination: Place.fromMap(map['destination']),
      stops: myStops,
    );
  }

  Trip returnTrip() {
    return Trip(
      tripId: null,
      reason: this.reason,
      startingTime: DateTime.now(),
      arrivalTime: null,
      source: this.destination,
      destination: this.source,
      stops: [],
    );
  }

  Trip copyWith({
    int tripId,
    String reason,
    DateTime startingTime,
    DateTime arrivalTime,
    Place source,
    Place destination,
    List<Position> stops,
  }) {
    return Trip(
      tripId: tripId ?? this.tripId,
      reason: reason ?? this.reason,
      startingTime: startingTime ?? this.startingTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      stops: stops ?? this.stops,
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
        stops,
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
      stops: $stops,
    }''';
  }
}
