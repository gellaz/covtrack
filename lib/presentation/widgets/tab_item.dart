import 'package:flutter/material.dart';

import '../../utils/routers.dart';

class TabItem {
  final Router router;

  const TabItem({
    @required this.router,
  });

  factory TabItem.settings() => TabItem(router: SettingsRouter());

  factory TabItem.home() => TabItem(router: HomeRouter());

  factory TabItem.info() => TabItem(router: NewsRouter());
}
