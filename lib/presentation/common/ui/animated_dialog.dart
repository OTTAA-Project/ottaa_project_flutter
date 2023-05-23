import 'package:flutter/material.dart';

class AnimatedDialog {
  static Future<T?> animate<T>(BuildContext context, Widget builder) {
    return showGeneralDialog<T>(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation.drive(CurveTween(curve: Curves.easeInOut)),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: builder,
        );
      },
    );
  }
}
