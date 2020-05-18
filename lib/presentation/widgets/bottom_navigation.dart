import 'package:flutter/material.dart';

import 'tab_item.dart';

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
        _buildItem(tabs[TabIndex.donate]),
        _buildItem(tabs[TabIndex.home]),
        _buildItem(tabs[TabIndex.info]),
      ],
      onTap: (index) => onSelectTab(TabIndex.values[index]),
      type: BottomNavigationBarType.fixed,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: tabItem.icon,
      title: tabItem.title,
    );
  }
}
