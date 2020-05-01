import 'package:covtrack/routes/routers.dart';
import 'package:flutter/material.dart';

enum TabIndex { donate, home, info }

class TabItem {
  final Router router;
  final Icon icon;
  final Text title;

  TabItem({
    @required this.router,
    @required this.icon,
    this.title,
  });

  factory TabItem.home() {
    return TabItem(
      router: HomeRouter(),
      icon: Icon(Icons.home),
      title: Text('Home'),
    );
  }

  factory TabItem.donate() {
    return TabItem(
      router: DonateRouter(),
      icon: Icon(Icons.favorite),
      title: Text('Donate'),
    );
  }

  factory TabItem.info() {
    return TabItem(
      router: InfoRouter(),
      icon: Icon(Icons.info),
      title: Text('Info'),
    );
  }
}
