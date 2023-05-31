import 'package:chat_app/widgets/home/welcome.dart';
import 'package:flutter/material.dart';

import '../widgets/home/recent_convos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [
          WelcomeWidget(),
          RecentConvos(),
        ],
      ),
    );
  }
}
