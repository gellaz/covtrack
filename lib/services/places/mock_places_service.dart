part of 'places_service.dart';

class MockPlacesService implements PlacesService {
  // List<Place> places = [
  //   Place(
  //     latitude: 44.496993,
  //     longitude: 11.357393,
  //     address: 'Viale Quirico Filopanti, 4, 40126 Bologna BO',
  //   ),
  //   Place(
  //     latitude: 44.492398,
  //     longitude: 11.364709,
  //     address: 'Via Giuseppe Bentivogli, 2a, 40138 Bologna BO',
  //   ),
  //   Place(
  //     latitude: 44.497469,
  //     longitude: 11.364274,
  //     address: 'Via Giuseppe Bentivogli, 99/C, 40138 Bologna BO',
  //   ),
  //   Place(
  //     latitude: 44.493601,
  //     longitude: 11.313010,
  //     address: 'Via Andrea Costa, 156/2, 40134 Bologna BO',
  //   ),
  // ];

  // @override
  // Future<List<Place>> getPlaces({String input}) async {
  //   await Future.delayed(Duration(seconds: 2));
  //   return places;
  // }

  @override
  Future<Place> fetchPlaceDetails({String placeId}) {
    // TODO: implement fetchPlaceDetails
    return null;
  }

  @override
  Future<List<PlaceSuggestion>> fetchSuggestions({String input}) {
    // TODO: implement fetchSuggestions
    return null;
  }
}
