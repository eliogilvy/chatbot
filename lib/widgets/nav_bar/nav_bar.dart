import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/navigation_provider.dart';

class ChatNavBar extends StatelessWidget {
  ChatNavBar({super.key});

  final List<DotNavigationBarItem> items = [
    DotNavigationBarItem(
      icon: const Icon(Icons.home),
    ),
    DotNavigationBarItem(
      icon: const Icon(Icons.chat),
    ),
    DotNavigationBarItem(
      icon: const Icon(Icons.person),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final auth = Provider.of<AuthProvider>(context);
    return StreamBuilder(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? DotNavigationBar(
                  currentIndex: navProvider.currentIndex,
                  items: items,
                  selectedItemColor: colorScheme.primary,
                  unselectedItemColor: colorScheme.secondary,
                  onTap: (index) => navProvider.updateIndex(index),
                  backgroundColor: colorScheme.background,
                  curve: Curves.decelerate,
                )
              : const SizedBox.shrink();
        });
  }
}
