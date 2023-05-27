import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(child: child),
    );
  }
}
