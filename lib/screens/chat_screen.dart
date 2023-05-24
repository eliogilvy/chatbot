import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import '../provider/messaging_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.convoID});

  final String convoID;

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessagingProvider>(context);
    final stream = messageProvider.messages(convoID);
    return StreamBuilder<List<types.Message>>(
      stream: stream,
      builder: (context, snapshot) {
        return Chat(
          messages: snapshot.data ?? [],
          onSendPressed: (message) => print('sent'),
          user: messageProvider.getChatUser(),
          theme: DefaultChatTheme(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        );
      },
    );
  }
}
