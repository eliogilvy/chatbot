import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';
import 'package:chat_app/screens/screen_list.dart';
import '../widgets/utils/routes.dart';
import '../widgets/nav_bar/nav_bar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat app'),
      ),
      body: StreamBuilder(
          stream: auth.authStateChanges,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const AuthScreen()
                : IndexedStack(
                    index: navProvider.currentIndex,
                    children: screenList,
                  );
          }),
      bottomNavigationBar: ChatNavBar(),
    );
  }
}
