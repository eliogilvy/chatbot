import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/navigation_provider.dart';

enum TabItem { home, conversations, profile }

enum ViewItem { messages }

class ChatNavBar extends StatelessWidget {
  ChatNavBar({super.key});

  final List<DotNavigationBarItem> items = [
    DotNavigationBarItem(
      icon: const Icon(Icons.home),
    ),
    DotNavigationBarItem(
      icon: const Icon(Icons.list),
    ),
    DotNavigationBarItem(
      icon: const Icon(Icons.person),
    ),
  ];

  final List<BottomNavigationBarItem> i = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Convos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        return snapshot.hasData
            // ? DotNavigationBar(
            //     currentIndex: navProvider.currentTab.index,
            //     items: items,
            //     selectedItemColor: colorScheme.primary,
            //     unselectedItemColor: colorScheme.secondary,
            //     onTap: (index) => _onTap(
            //       index,
            //       navProvider,
            //       context,
            //       navProvider.currentTab,
            //     ),
            //     backgroundColor: colorScheme.background,
            //     curve: Curves.decelerate,
            //   )
            ? BottomNavigationBar(
                items: i,
                onTap: (index) => _onTap(index, navProvider, context),
              )
            : const SizedBox.shrink();
      },
    );
  }

  void _onTap(int index, NavigationProvider navProvider, BuildContext context) {
    //switch statement for route names
    String route = '';
    switch (index) {
      case 0:
        route = '/';
        break;
      case 1:
        route = '/conversations';
        break;
      case 2:
        route = '/profile';
        break;
    }

    navProvider.updateTab(index, context);
    context.go(route);
  }
}
