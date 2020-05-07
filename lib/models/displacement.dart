import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';

class Displacement extends Equatable {
  final String id;
  final String reason;
  final DateTime startingTime;
  final DateTime arrivalTime;
  final Place source;
  final Place destination;

  Displacement({
    @required this.id,
    @required this.reason,
    @required this.startingTime,
    @required this.arrivalTime,
    @required this.source,
    @required this.destination,
  });

  Displacement copyWith({
    String id,
    String reason,
    DateTime startingTime,
    DateTime arrivalTime,
    Place source,
    Place destination,
  }) {
    return Displacement(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      startingTime: startingTime ?? this.startingTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      source: source ?? this.source,
      destination: destination ?? this.destination,
    );
  }

  @override
  List<Object> get props => [
        id,
        reason,
        startingTime,
        arrivalTime,
        source,
        destination,
      ];

  @override
  String toString() {
    return '''
    Displacement {
      id: $id,
      reason: $reason,
      startingTime: $startingTime,
      arrivalTime: $arrivalTime,
      source: $source,
      destination: $destination,
    }''';
  }
}
