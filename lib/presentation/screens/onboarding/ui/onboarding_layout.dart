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

    final height = size.height;

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
              style: textTheme.headline3,
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Text(
              widget.subtitle,
              style: textTheme.headline1?.copyWith(
                color: colorScheme.primary,
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
            flex: 1,
            fit: FlexFit.loose,
            child: Text(
              widget.description,
              style: textTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
