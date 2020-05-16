import 'package:flutter/material.dart';

import '../places_picker/places_picker.dart';

class DestinationPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlacesPicker(onPlaceSelected: () {
      Navigator.pushNamed(context, '/home/destination-picker');
    });
  }
}
