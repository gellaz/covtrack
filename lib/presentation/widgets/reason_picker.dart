import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReasonPicker extends StatelessWidget {
  final List<String> reasonsList;
  final ValueChanged<int> onSelectedItemChanged;

  const ReasonPicker(this.reasonsList, this.onSelectedItemChanged, {Key key})
      : assert(reasonsList != null),
        assert(onSelectedItemChanged != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      children: reasonsList.map((reason) {
        return Center(
          child: Text(
            reason,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
      itemExtent: 50,
      onSelectedItemChanged: onSelectedItemChanged,
    );
  }
}
