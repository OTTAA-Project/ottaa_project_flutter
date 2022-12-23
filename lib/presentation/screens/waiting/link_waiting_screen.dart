import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_loading_animation.dart';

class LinkWaitingScreen extends ConsumerStatefulWidget {
  const LinkWaitingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkWaitingScreenState();
}

class _LinkWaitingScreenState extends ConsumerState<LinkWaitingScreen> {
  @override
  void initState() {
    SplashProvider provider = ref.read(splashProvider);

    final localContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //TODO:
      // Implement the function that load the linked account
      // and then go to the customize board screen
      await Future.delayed(const Duration(seconds: 3));

      localContext.push(AppRoutes.linkSuccessScreen);
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
              "link.wait.title".trl,
              style: textTheme.headline2,
            ),
            const SizedBox(height: 10),
            Text(
              "link.wait.subtitle".trl,
              style: textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
