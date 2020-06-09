import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';

class ReasonDropdown extends StatefulWidget {
  final Function onReasonSelected;

  const ReasonDropdown({Key key, @required this.onReasonSelected})
      : assert(onReasonSelected != null),
        super(key: key);

  @override
  _ReasonDropdownState createState() => _ReasonDropdownState();
}

class _ReasonDropdownState extends State<ReasonDropdown> {
  String selectedReason;

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
          hint: Text(
            AppLocalizations.of(context).selectReason,
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          ),
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
          items: <DropdownMenuItem<String>>[
            DropdownMenuItem<String>(
              value: AppLocalizations.of(context).reason1,
              child: Text(
                AppLocalizations.of(context).reason1,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ),
            DropdownMenuItem<String>(
              value: AppLocalizations.of(context).reason2,
              child: Text(
                AppLocalizations.of(context).reason2,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ),
            DropdownMenuItem<String>(
              value: AppLocalizations.of(context).reason3,
              child: Text(
                AppLocalizations.of(context).reason3,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onChanged(String newReason) {
    setState(() => selectedReason = newReason);
    widget.onReasonSelected(newReason);
  }
}
