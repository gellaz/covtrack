import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReasonPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      children: <Widget>[
        Center(
            child: Text(
          'reason 1',
          textAlign: TextAlign.center,
        )),
        Center(
            child: Text(
          'reason 2',
          textAlign: TextAlign.center,
        )),
        Center(
            child: Text(
          'reason 3',
          textAlign: TextAlign.center,
        )),
      ],
      itemExtent: 50,
      onSelectedItemChanged: (int value) {},
    );
  }
}
