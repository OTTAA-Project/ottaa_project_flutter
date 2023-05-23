import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_loading_animation.dart';

class LinkWaitingScreen extends ConsumerStatefulWidget {
  const LinkWaitingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LinkWaitingScreenState();
}

class _LinkWaitingScreenState extends ConsumerState<LinkWaitingScreen> {
  @override
  void initState() {

    final localContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));

      localContext.go(AppRoutes.caregiverLinkSuccess);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBody: true,
      body: SizedBox.fromSize(
        size: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OttaaLoadingAnimation(),
            const SizedBox(height: 40),
            Text(
              "profile.link.wait.title".trl,
              style: textTheme.displayMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "profile.link.wait.subtitle".trl,
              style: textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
