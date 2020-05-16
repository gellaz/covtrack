import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';

class Trip extends Equatable {
  final String tripId;
  final String reason;
  final DateTime startingTime;
  final DateTime arrivalTime;
  final Place source;
  final Place destination;

  Trip({
    @required this.tripId,
    @required this.reason,
    @required this.startingTime,
    @required this.arrivalTime,
    @required this.source,
    @required this.destination,
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
