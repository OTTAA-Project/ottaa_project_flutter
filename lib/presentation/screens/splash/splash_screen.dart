import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_loading_animation.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashProvider provider = ref.read(splashProvider);

    final isLogged = ref.read(authNotifier);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await blockPortraitMode();

      setState(() {});

      return context.go(AppRoutes.waitingLogin, extra: 0);
      if (isLogged) {
        bool isFirstTime = await provider.isFirstTime();
        bool hasPhoto = await provider.checkUserAvatar();
        bool hasInfo = await provider.fetchUserInformation();

        if (mounted) {
          if (!hasInfo) {
            return context.go(AppRoutes.login);
          }
          if (isFirstTime) {
            return context.go(AppRoutes.onboarding, extra: 0);
          }

          if (!hasPhoto) {
            return context.go(AppRoutes.onboarding, extra: 2);
          }

          return context.go(AppRoutes.home);
        }
      }
      if (mounted) return context.go(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const OttaaLoadingAnimation(
                width: 40,
                height: 100,
              ),
              const SizedBox(width: 20),
              Text(
                "Hello".trl,
                style: textTheme.headline1?.copyWith(color: Theme.of(context).primaryColor, fontSize: 40),
              ), //TODO: CHange this
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(AppImages.kLogoOttaa),
              width: size.width * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
