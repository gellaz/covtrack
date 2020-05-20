import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/info.dart';

class InfoListView extends StatelessWidget {
  final Info info;

  const InfoListView(this.info, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildListTile(
          Icon(Icons.local_hotel, color: Colors.yellow[700]),
          'Confirmed:',
          info.confirmed,
        ),
        _buildListTile(
          Icon(Icons.local_hospital, color: Colors.red),
          'Deaths:',
          info.deaths,
        ),
        _buildListTile(
          Icon(Icons.sentiment_satisfied, color: Colors.green),
          'Recovered:',
          info.recovered,
        ),
      ],
    );
  }

  Widget _buildListTile(Icon icon, String title, int data) {
    var f = NumberFormat.compact();
    return Card(
      child: ListTile(
        leading: icon,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Text('${f.format(data)}'),
          ],
        ),
      ),
    );
  }
}
