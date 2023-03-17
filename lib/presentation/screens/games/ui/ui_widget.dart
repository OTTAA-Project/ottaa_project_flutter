import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';

class UIWidget extends StatelessWidget {
  const UIWidget({
    Key? key,
    required this.subtitle,
    required this.headline,
    required this.uiWidget,
    required this.show,
  }) : super(key: key);
  final String headline, subtitle;
  final Widget uiWidget;
  final bool show;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        const BackGroundWidget(),
        HeaderWidget(
          headline: headline,
          subtitle: subtitle,
        ),
        Center(
          child: uiWidget,
        ),
        !show
            ? Positioned(
                bottom: 60,
                left: 150,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        show
            ? Positioned(
                bottom: 60,
                right: 150,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
