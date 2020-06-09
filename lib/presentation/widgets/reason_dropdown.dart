import 'package:flutter/material.dart';

class ReasonDropdown extends StatefulWidget {
  final List<String> reasonsList;
  final Function onReasonSelected;

  const ReasonDropdown({
    Key key,
    @required this.reasonsList,
    @required this.onReasonSelected,
  })  : assert(reasonsList != null),
        assert(onReasonSelected != null),
        super(key: key);

  @override
  _ReasonDropdownState createState() => _ReasonDropdownState();
}

class _ReasonDropdownState extends State<ReasonDropdown> {
  List<DropdownMenuItem<String>> dropdownItems;
  String selectedReason;

  @override
  void initState() {
    super.initState();
    selectedReason = widget.reasonsList.first;
    dropdownItems =
        widget.reasonsList.map<DropdownMenuItem<String>>((String reason) {
      return DropdownMenuItem<String>(
        value: reason,
        child: Text(reason),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.not_listed_location),
        title: DropdownButton<String>(
          value: selectedReason,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: Theme.of(context).accentColor,
          ),
          onChanged: onChanged,
          items: dropdownItems,
        ),
      ),
    );
  }

  void onChanged(String newReason) {
    setState(() => selectedReason = newReason);
    widget.onReasonSelected(newReason);
  }
}
