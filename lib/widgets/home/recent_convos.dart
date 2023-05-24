import 'package:chat_app/widgets/utils/lists/convo_list.dart';
import 'package:flutter/material.dart';

class RecentConvos extends StatelessWidget {
  const RecentConvos({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text(
            'Recent Conversations',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const ConvoList(),
        ],
      ),
    );
  }
}
