import 'package:flutter/material.dart';

import '../../utils/app_localizations.dart';
import 'tab_item.dart';

enum TabIndex { info, home, settings }

class BottomNavigation extends StatelessWidget {
  final TabIndex currentTab;
  final ValueChanged<TabIndex> onSelectTab;
  final Map<TabIndex, TabItem> tabs;

  const BottomNavigation({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      items: [
        _buildNewsItem(context),
        _buildHomeItem(context),
        _buildSettingsItem(context),
      ],
      onTap: (index) => onSelectTab(TabIndex.values[index]),
      type: BottomNavigationBarType.fixed,
    );
  }

  BottomNavigationBarItem _buildNewsItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: Icon(Icons.library_books),
      title: Text(AppLocalizations.of(context).news),
    );
  }

  BottomNavigationBarItem _buildHomeItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(AppLocalizations.of(context).home),
    );
  }

  BottomNavigationBarItem _buildSettingsItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text(AppLocalizations.of(context).settings),
    );
  }
}
