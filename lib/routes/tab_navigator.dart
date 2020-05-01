import 'package:covtrack/routes/tab_item.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = tabItem.router;
    return Navigator(
      key: navigatorKey,
      initialRoute: router.initialRoute,
      onGenerateRoute: (settings) => router.generateRoute(settings),
    );
  }
}