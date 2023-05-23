import 'package:chat_app/screens/base_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const BaseScreen(),
    ),
    GoRoute(
      path: '/conversation/:id',
      builder: (context, state) => ChatScreen(
        convoID: state.pathParameters['id'] as String,
      ),
    ),
  ],
);
