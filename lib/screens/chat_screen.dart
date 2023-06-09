import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/provider/bot_provider.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/messaging_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.convoId});

  final String convoId;

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessagingProvider>(context);
    final botProvider = Provider.of<BotProvider>(context);
    final stream = messageProvider.messages(convoId);
    return FutureBuilder<Conversation>(
        future: messageProvider.getConversation(convoId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.title),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/conversations'),
                ),
              ),
              body: StreamBuilder<List<types.Message>>(
                stream: stream,
                builder: (context, snapshot) {
                  print(snapshot.data!.length);
                  return Chat(
                    messages: snapshot.data ?? [],
                    onSendPressed: (message) async {
                      final res = await botProvider.getBotResponse(
                        {'message': message.text},
                      );
                      await messageProvider.addMessage(message, convoId, false);

                      await messageProvider.addMessage(
                          types.PartialText(text: res), convoId, true);
                    },
                    
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
                  );
                },
              ),
            );
          }
          return const Center(
            child: FallingDot(),
          );
        });
  }
}
