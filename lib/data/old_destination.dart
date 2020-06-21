import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'place.dart';

class OldDestination extends Equatable {
  final Place place;
  final int numVisits;

  const OldDestination({
    @required this.place,
    @required this.numVisits,
  });

  String get coordsStr => '${place.coords.latLngStr}';

  Map<String, Object> toJson() {
    return {
      "place": place.toJson(),
      "numVisits": numVisits,
    };
  }

  factory OldDestination.fromJson(Map<String, Object> json) {
    return OldDestination(
      place: Place.fromJson(json['place']),
      numVisits: json['numVisits'] as int,
    );
  }

  factory OldDestination.fromSnapshot(DocumentSnapshot snap) {
    return OldDestination(
      place: Place.fromJson(snap.data['place']),
      numVisits: snap.data['numVisits'] as int,
    );
  }

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
