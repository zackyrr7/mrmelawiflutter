import 'package:flutter/material.dart';

class CommonBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Widget child) builder;
  final Widget child;
  const CommonBuilder({super.key, required this.builder, required this.child});

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
