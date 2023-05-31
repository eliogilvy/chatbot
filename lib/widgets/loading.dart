import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FallingDot extends StatelessWidget {
  const FallingDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
          color: Theme.of(context).primaryColor, size: 50),
    );
  }
}
