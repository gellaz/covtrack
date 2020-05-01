import 'package:covtrack/routes/tab_item.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final TabIndex currentTab;
  final Map<TabIndex, TabItem> tabs;
  final ValueChanged<TabIndex> onSelectTab;

  const BottomNavigation({
    Key key,
    @required this.currentTab,
    @required this.tabs,
    @required this.onSelectTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: tabs[TabIndex.donate]),
        _buildItem(tabItem: tabs[TabIndex.home]),
        _buildItem(tabItem: tabs[TabIndex.info]),
      ],
      onTap: (index) => onSelectTab(
        TabIndex.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    return BottomNavigationBarItem(
      icon: tabItem.icon,
      title: tabItem.title,
    );
  }
}
