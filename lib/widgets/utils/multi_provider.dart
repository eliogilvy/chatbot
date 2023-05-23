import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/provider/messaging_provider.dart';
import 'package:chat_app/provider/navigation_provider.dart';
import 'package:chat_app/provider/settings_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends StatelessWidget {
  const ChatProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(
          create: (_) => MessagingProvider(fb: fb, auth: auth),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(firebaseAuth: auth, fb: fb),
        ),
      ],
      child: child,
    );
  }
}
