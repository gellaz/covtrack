import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/news.dart';
import '../../utils/app_localizations.dart';

class NewsListView extends StatelessWidget {
  final News info;

  const NewsListView(this.info, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildListTile(
          context,
          Icon(Icons.local_hotel, color: Colors.yellow[700]),
          AppLocalizations.of(context).confirmed,
          info.confirmed,
        ),
        _buildListTile(
          context,
          Icon(Icons.local_hospital, color: Colors.red),
          AppLocalizations.of(context).deaths,
          info.deaths,
        ),
        _buildListTile(
          context,
          Icon(Icons.sentiment_satisfied, color: Colors.green),
          AppLocalizations.of(context).recovered,
          info.recovered,
        ),
      ],
    );
  }

  Widget _buildListTile(
      BuildContext context, Icon icon, String title, int data) {
    var f = NumberFormat.decimalPattern();
    return Card(
      child: ListTile(
        leading: icon,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Text(
              '${f.format(data)}',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      ),
    );
  }
}
