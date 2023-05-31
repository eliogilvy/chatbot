import 'package:chat_app/widgets/lists/convo_list.dart';
import 'package:flutter/material.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
      ),
      body: const Column(
        children: [
          ConvoList(),
        ],
      ),
    );
  }
}
