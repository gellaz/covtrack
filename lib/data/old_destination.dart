import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';

/// Class representing a destination reached in the past by the user with a trip.
class OldDestination extends Equatable {
  /// Visited place.
  final Place place;

  /// How many times the user has reached the destination.
  final int numVisits;

  const OldDestination({
    @required this.place,
    @required this.numVisits,
  });

  /// Getter returning a string with the coordinates of the point
  /// in the following format: '[latitude],[longitude]'.
  String get coordsStr => '${place.coords.latLngStr}';

  /// Serializes the [OldDestination] object into a JSON format object.
  Map<String, Object> toJson() {
    return {
      "place": place.toJson(),
      "numVisits": numVisits,
    };
  }

  /// Deserializes the input [json] object into an [OldDestination] object.
  factory OldDestination.fromJson(Map<String, Object> json) {
    return OldDestination(
      place: Place.fromJson(json['place']),
      numVisits: json['numVisits'] as int,
    );
  }

  /// Deserializes the input DocumentSnapshot object ([snap]) object
  /// into an [OldDestination] object. DocumentSnapshot is the class
  /// representing a document in Cloud Firestore data model.
  factory OldDestination.fromSnapshot(DocumentSnapshot snap) {
    return OldDestination(
      place: Place.fromJson(snap.data['place']),
      numVisits: snap.data['numVisits'] as int,
    );
  }

  /// Returns a copy of the [OldDestination] object where only the properties
  /// passed in as arguments are updated.
  OldDestination copyWith({
    Place place,
    int numVisits,
  }) {
    return OldDestination(
      place: place ?? this.place,
      numVisits: numVisits ?? this.numVisits,
    );
  }

  @override
  List<Object> get props => [
        place,
        numVisits,
      ];

  @override
  String toString() {
    return '''
    OldDestination {
      place: $place,
      numVisits: $numVisits,
    }''';
  }
}
