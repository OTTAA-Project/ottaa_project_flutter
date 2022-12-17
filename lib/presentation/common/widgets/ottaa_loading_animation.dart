import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OttaaLoadingAnimation extends StatelessWidget {
  final double? width;
  final double? height;

  const OttaaLoadingAnimation({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100,
      height: height ?? 100,
      child: const RiveAnimation.asset(
        'assets/rive/loading_ottaa.riv',
        fit: BoxFit.contain,
        alignment: Alignment.center,
        placeHolder: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );
  }
}