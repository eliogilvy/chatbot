import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const AuthScreen()
              : child;
        },
      ),
      bottomNavigationBar: ChatNavBar(),
    );
  }
}
