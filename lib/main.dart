import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/widgets/utils/routes.dart';
import 'package:chat_app/widgets/utils/multi_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BuddyAi());
}

class BuddyAi extends StatelessWidget {
  const BuddyAi({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChatProvider(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: router,
        theme: lightTheme,
        darkTheme: darktheme,
      ),
    );
  }
}
