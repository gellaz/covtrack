import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';

class Trip extends Equatable {
  @required
  final String tripId;
  @required
  final String reason;
  @required
  final DateTime startingTime;
  @required
  final DateTime arrivalTime;
  @required
  final Place source;
  @required
  final Place destination;

  Trip({
    this.tripId,
    this.reason,
    this.startingTime,
    this.arrivalTime,
    this.source,
    this.destination,
  });

  Trip copyWith({
    String tripId,
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
