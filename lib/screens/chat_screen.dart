import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import '../provider/messaging_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessagingProvider>(context);
    return StreamBuilder(
        stream: messageProvider.messages,
        builder: (context, snapshot) {
          final messages = snapshot.data ?? [];
          return Chat(
            messages: messages,
            onSendPressed: (message) => messageProvider.addMessage(message),
            user: messageProvider.getChatUser(),
            theme: DefaultChatTheme(
                backgroundColor: Theme.of(context).colorScheme.background),
          );
        });
  }
}
