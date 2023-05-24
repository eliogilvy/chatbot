import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Align(
      alignment: Alignment.topLeft,
      child: FutureBuilder<String>(
        future: auth.getUserName(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const FallingDot()
              : snapshot.data != null && snapshot.data!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Welcome, ${snapshot.data}',
                              speed: const Duration(milliseconds: 75),
                              textStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              curve: Curves.slowMiddle,
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    )
                  : const Text('Unknown Error');
        },
      ),
    );
  }
}
