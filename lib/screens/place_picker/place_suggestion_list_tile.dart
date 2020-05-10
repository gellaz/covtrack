import 'package:flutter/material.dart';

import '../../models/place_suggestion.dart';

class PlaceSuggestionListTile extends StatelessWidget {
  final PlaceSuggestion placeSuggestion;

  const PlaceSuggestionListTile({Key key, @required this.placeSuggestion})
      : assert(placeSuggestion != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.pin_drop),
      title: Text(placeSuggestion.mainText),
      subtitle: Text(placeSuggestion.secondaryText),
    );
  }
}
