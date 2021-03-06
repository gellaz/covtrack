import 'package:flutter/material.dart';

import '../widgets/bottom_navigation.dart';
import '../widgets/tab_item.dart';
import '../widgets/tab_navigator.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  TabIndex _currentTab = TabIndex.home;

  final Map<TabIndex, TabItem> _tabs = {
    TabIndex.settings: TabItem.settings(),
    TabIndex.home: TabItem.home(),
    TabIndex.info: TabItem.info(),
  };

  final Map<TabIndex, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabIndex.settings: GlobalKey<NavigatorState>(),
    TabIndex.home: GlobalKey<NavigatorState>(),
    TabIndex.info: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(TabIndex.info),
            _buildOffstageNavigator(TabIndex.home),
            _buildOffstageNavigator(TabIndex.settings),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          tabs: _tabs,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabIndex tabIndex) {
    return Offstage(
      offstage: _currentTab != tabIndex,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabIndex],
        tabItem: _tabs[tabIndex],
      ),
    );
  }

  void _selectTab(TabIndex tabIndex) {
    tabIndex == _currentTab
        ? _navigatorKeys[tabIndex]
            .currentState
            .popUntil((route) => route.isFirst)
        : setState(() => _currentTab = tabIndex);
  }
}
