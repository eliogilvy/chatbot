import 'package:chat_app/screens/base_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/widgets/lists/convo_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _baseNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavKey = GlobalKey<NavigatorState>();


final router = GoRouter(
  navigatorKey: _baseNavKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavKey,
      builder: (context, state, child) => BaseScreen(
        key: state.pageKey,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/',
          builder: (
            context,
            state,
          ) =>
              const HomeScreen(),
        ),
        GoRoute(
          path: '/conversations',
          builder: (context, state) => const ConvoList(),
        ),
        GoRoute(
          path: '/conversations/:id',
          builder: (context, state) => ChatScreen(
            convoID: state.pathParameters['id'] as String,
          ),
        ),
      ],
    )
  ],
);
