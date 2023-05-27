import 'package:chat_app/provider/bot_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/messaging_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.convoID});

  final String convoID;

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessagingProvider>(context);
    final botProvider = Provider.of<BotProvider>(context);
    final stream = messageProvider.messages(convoID);
    return StreamBuilder<List<types.Message>>(
      stream: stream,
      builder: (context, snapshot) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => context.go('/conversations'),
                ),
              ],
            ),
            Expanded(
              child: Chat(
                messages: snapshot.data ?? [],
                onSendPressed: (message) async =>
                    await botProvider.getBotResponse(
                  {'message': message.text},
                ),
                user: messageProvider.getChatUser(),
                theme: DefaultChatTheme(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  inputContainerDecoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
