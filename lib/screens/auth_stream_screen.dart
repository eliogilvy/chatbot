import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/base_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final auth = authProvider.authStateChanges;
    return StreamBuilder(
      stream: auth,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const AuthScreen()
            : const BaseScreen(
                child: HomeScreen(),
              );
      },
    );
  }
}
