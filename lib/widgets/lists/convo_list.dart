import 'package:chat_app/provider/messaging_provider.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/conversation.dart';

class ConvoList extends StatelessWidget {
  const ConvoList({super.key, this.limit});
  final int? limit;

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessagingProvider>(context);
    return FutureBuilder<List<Conversation>>(
      future: messageProvider.loadConversations(limit: limit),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: FallingDot(),
                )
              : snapshot.data != null && snapshot.data!.isNotEmpty
                  ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final convo = snapshot.data![index];
                      return ConversationTile(convo: convo);
                    },
                  )
                  : const Text('No Conversations'),
    );
  }
}
