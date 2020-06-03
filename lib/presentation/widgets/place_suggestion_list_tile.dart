import 'package:flutter/material.dart';

import '../../data/place_suggestion.dart';

class PlaceSuggestionListTile extends StatelessWidget {
  final PlaceSuggestion suggestion;

  const PlaceSuggestionListTile(this.suggestion, {Key key})
      : assert(suggestion != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.pin_drop),
      title: Text(suggestion.mainText),
      subtitle: Text(suggestion.secondaryText),
    );
  }
}