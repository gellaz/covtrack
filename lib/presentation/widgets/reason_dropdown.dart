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
  String selectedReason;

  @override
  void initState() {
    super.initState();
    selectedReason = widget.reasonsList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(
          Icons.not_listed_location,
          color: Theme.of(context).accentColor,
        ),
        title: DropdownButton<String>(
          value: selectedReason,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).iconTheme.color,
          ),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: Theme.of(context).accentColor,
          ),
          onChanged: onChanged,
          items:
              widget.reasonsList.map<DropdownMenuItem<String>>((String reason) {
            return DropdownMenuItem<String>(
              value: reason,
              child: Text(
                reason,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void onChanged(String newReason) {
    setState(() => selectedReason = newReason);
    widget.onReasonSelected(newReason);
  }
}
