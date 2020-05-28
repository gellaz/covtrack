import 'package:flutter/material.dart';

import '../../routes/routers.dart';

enum TabIndex { info, home, settings }

class TabItem {
  final Router router;
  final Icon icon;
  final Text title;

  TabItem({
    @required this.router,
    @required this.icon,
    this.title,
  });

  factory TabItem.settings() {
    return TabItem(
      router: DonateRouter(),
      icon: Icon(Icons.settings),
      title: Text('Settings'),
    );
  }

  factory TabItem.home() {
    return TabItem(
      router: HomeRouter(),
      icon: Icon(Icons.home),
      title: Text('Home'),
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
