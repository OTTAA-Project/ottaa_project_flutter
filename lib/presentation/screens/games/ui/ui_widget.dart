import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';

class UIWidget extends StatelessWidget {
  const UIWidget({
    Key? key,
    required this.subtitle,
    required this.headline,
    required this.uiWidget,
    required this.backward,
    required this.forward,
  }) : super(key: key);
  final String headline, subtitle;
  final Widget uiWidget;
  final void Function()? forward, backward;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackGroundWidget(),
        HeaderWidget(
          headline: headline,
          subtitle: subtitle,
          bold: false,
        ),
        Center(
          child: uiWidget,
        ),
        Positioned(
          bottom: size.height * 0.2,
          left: size.width * 0.13,
          child: GestureDetector(
            onTap: backward,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: size.height*0.03,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: size.height * 0.2,
          right: size.width * 0.13,
          child: GestureDetector(
            onTap: forward,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: size.height*0.03,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
