import 'package:chat_app/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigationProvider();
  TabItem _currentTab = TabItem.home;
  ViewItem? _viewTab;

  TabItem get currentTab => _currentTab;
  ViewItem? get currentView => _viewTab;

  void updateTab(int tabItem, BuildContext context,) {
    _currentTab = TabItem.values[tabItem];
  }

  void updateView(int? viewItem) {
    _viewTab = viewItem == null ? null : ViewItem.values[viewItem];
  }
}
