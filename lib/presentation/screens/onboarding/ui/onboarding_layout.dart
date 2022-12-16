import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: textTheme.headline3,
        ),
        SizedBox(height: height * 0.05),
        Text(
          widget.subtitle,
          style: textTheme.headline1?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        SizedBox(height: height * 0.05),
        Image.asset(
          widget.image,
        ),
        SizedBox(height: height * 0.05),
        Text(widget.description, style: textTheme.headline3),
        SizedBox(height: height * 0.05),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
