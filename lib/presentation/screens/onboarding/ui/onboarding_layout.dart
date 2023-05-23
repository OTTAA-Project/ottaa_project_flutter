import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingLayout extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;

  final String description;

  final String image;

  const OnboardingLayout({super.key, required this.title, required this.subtitle, required this.description, required this.image});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoStepState();
}

class _UserInfoStepState extends ConsumerState<OnboardingLayout> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.fromSize(
      size: size,
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Text(
              widget.title,
              style: textTheme.displaySmall,
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: textTheme.displayLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: Image.asset(
              widget.image,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AutoSizeText(
                widget.description,
                textAlign: TextAlign.center,
                style: textTheme.displaySmall,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
