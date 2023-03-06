import 'package:flutter/material.dart';

class OnboardinPageIndicator extends StatelessWidget {
  final bool active;

  const OnboardinPageIndicator({super.key, this.active = false});

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: active ? 40 : 8,
      decoration: BoxDecoration(
        color: active ? colorSchema.primary : colorSchema.background,
        borderRadius: BorderRadius.circular(5,),
        border: Border.all(
          color: colorSchema.primary,
          width: 2,
        ),
      ),
    );
  }
}
