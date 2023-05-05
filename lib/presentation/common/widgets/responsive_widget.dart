import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ottaa_ui_kit/theme.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget child;

  const ResponsiveWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            int maxSide = max(constraints.maxWidth, constraints.maxHeight).toInt();

            if (constraints.maxWidth > 1000) {
              switch (child.runtimeType) {
                case Scaffold:
                  return DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(kGray),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: maxSide * 0.2),
                      child: child,
                    ),
                  );
                default:
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: maxSide * 0.4,
                      child: child,
                    ),
                  );
              }
            } else {
              return child;
            }
          },
        );
      },
    );
  }
}
