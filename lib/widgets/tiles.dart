import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/provider/navigation_provider.dart';
import 'package:chat_app/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.convo,
  });

  final Conversation convo;

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final titleStyle = Theme.of(context).textTheme.headlineSmall;
    final subtitleStyle = Theme.of(context).textTheme.labelSmall;
    return ListTile(
        title: Center(
          child: Text(convo.title, style: titleStyle),
        ),
        subtitle: Center(
          child: Text(
            DateFormat('dd/MM/yyyy').format(
              DateTime.fromMillisecondsSinceEpoch(convo.createdAt),
            ),
            style: subtitleStyle,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          navigationProvider.updateTab(
            TabItem.conversations.index,
            context,
          );
          context.push('/conversations/${convo.id}');
        });
  }
}
