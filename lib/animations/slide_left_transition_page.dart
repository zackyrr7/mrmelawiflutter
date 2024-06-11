import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideLeftTransitionPage extends CustomTransitionPage {
  SlideLeftTransitionPage({
    required Widget child,
  }) : super(
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
        );
}
