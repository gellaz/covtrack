import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';
import 'stop.dart';

/// Class representing the trip of a user.
class Trip extends Equatable {
  /// Unique ID of the trip.
  final String tripId;

  /// Reason for the trip.
  final String reason;

  /// Exact time when the trip starts.
  final DateTime startingTime;

  /// Exact time when the trip ends.
  final DateTime arrivalTime;

  /// Place of departure of the trip.
  final Place source;

  /// Place of arrival of the trip.
  final Place destination;

  /// List containing all the stops of the trip.
  final List<Stop> stops;

  const Trip({
    @required this.tripId,
    @required this.reason,
    @required this.startingTime,
    @required this.arrivalTime,
    @required this.source,
    @required this.destination,
    @required this.stops,
  });

  /// Serializes the [Trip] object into a JSON format object.
  Map<String, Object> toJson() {
    return {
      "tripId": tripId,
      "reason": reason,
      "startingTime": startingTime?.toIso8601String(),
      "arrivalTime": arrivalTime?.toIso8601String(),
      "source": source.toJson(),
      "destination": destination.toJson(),
      "stops": stops.map((Stop s) => s.toJson()).toList(),
    };
  }

  /// Deserializes the input [json] object into an [Trip] object.
  factory Trip.fromJson(Map<String, Object> json) {
    List<Stop> _stops = [];

    (json['stops'] as List).forEach((v) => _stops.add(Stop.fromJson(v)));

    var _arrivalTime;
    if (json['arrivalTime'] != null) {
      _arrivalTime = DateTime.parse(json['arrivalTime'] as String);
    }

    return Trip(
      tripId: json['tripId'] as String,
      reason: json['reason'] as String,
      startingTime: DateTime.parse(json['startingTime'] as String),
      arrivalTime: _arrivalTime,
      source: Place.fromJson(json['source']),
      destination: Place.fromJson(json['destination']),
      stops: _stops,
    );
  }

  /// Deserializes the input DocumentSnapshot object ([snap]) object
  /// into a [Trip] object. DocumentSnapshot is the class
  /// representing a document in Cloud Firestore data model.
  factory Trip.fromSnapshot(DocumentSnapshot snap) {
    List<Stop> _stops = [];

    (snap.data['stops'] as List).forEach((v) => _stops.add(Stop.fromJson(v)));

    var _arrivalTime;
    if (snap.data['arrivalTime'] != null) {
      _arrivalTime = DateTime.parse(snap.data['arrivalTime'] as String);
    }
    return Trip(
      tripId: snap.documentID,
      reason: snap.data['reason'] as String,
      startingTime: DateTime.parse(snap.data['startingTime'] as String),
      arrivalTime: _arrivalTime,
      source: Place.fromJson(snap.data['source']),
      destination: Place.fromJson(snap.data['destination']),
      stops: _stops,
    );
  }

  /// Returns the return trip (source and destination swapped)
  /// starting from the current trip.
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

  /// Returns a copy of the [Trip] object where only the properties
  /// passed in as arguments are updated.
  Trip copyWith({
    String tripId,
    String reason,
    DateTime startingTime,
    DateTime arrivalTime,
    Place source,
    Place destination,
    List<Stop> stops,
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
