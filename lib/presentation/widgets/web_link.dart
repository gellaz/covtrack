import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebLink extends StatelessWidget {
  final String text;
  final String url;

  const WebLink({
    Key key,
    @required this.text,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: Theme.of(context).textTheme.overline,
        textAlign: TextAlign.center,
      ),
      onTap: _onTap,
    );
  }

  void _onTap() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('Cannot launch $url');
    }
  }
}
