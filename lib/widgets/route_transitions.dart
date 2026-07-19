import 'package:flutter/material.dart';

/// A subtle fade + upward-slide transition, used in place of the default
/// MaterialPageRoute cut everywhere in the app for a less "stock" feel.
/// Respects AppSettings.reduceMotion by collapsing to a plain instant swap
/// when motion is reduced.
Route<T> appRoute<T>(Widget page, {bool reduceMotion = false}) {
  if (reduceMotion) {
    return MaterialPageRoute<T>(builder: (_) => page);
  }
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}
