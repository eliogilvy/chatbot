import 'package:flutter/material.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    // Return listtile that is the primary conatianer color, with the title and subtitle, and rounded and slighlty elevated

    return ListTile(
      title: Center(child: Text(title)),
      subtitle: Center(child: Text(subtitle)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Theme.of(context).colorScheme.primary,
      onTap: () => onTap(),
    );
  }
}
