import 'package:chat_app/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/messaging_provider.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessagingProvider>(context);
    return FutureBuilder(
      future: messageProvider.conversations,
      builder: (context, snapshot) {
        return Center(
          child: snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snapshot.hasData
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final conversation = snapshot.data![index];
                          final convoID = conversation.id;
                          return snapshot.data!.isNotEmpty
                              ? ConversationTile(
                                  title: conversation.title,
                                  subtitle: DateFormat('dd/MM/yyyy').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        conversation.createdAt),
                                  ),
                                  onTap: () => context.push('/conversation/$convoID'),
                                )
                              : const Text('No conversations');
                        },
                      ),
                  )
                  : const Text('Unknown Error'),
        );
      },
    );
  }
}
