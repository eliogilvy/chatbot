import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../model/conversation.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.convo,
  });

  final Conversation convo;

  @override
  Widget build(BuildContext context) {
    // Return listtile that is the primary conatianer color, with the title and subtitle, and rounded and slighlty elevated
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
      onTap: () => context.push('/conversation/${convo.id}'),
    );
  }
}
