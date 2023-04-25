import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
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

    final auth = ref.read(authNotifier.notifier);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await blockPortraitMode();

      setState(() {});

      bool isLogged = await provider.fetchUserInformation();
      bool isFirstTime = await provider.isFirstTime();

      if (isLogged) {
        final user = ref.read(userProvider.select((value) => value.user));
        auth.setSignedIn();
        await I18N.of(context).changeLanguage(user?.settings.language.language ?? "es_AR");
        log(user?.settings.language.language ?? "NO LNG");
        if (mounted) {
          initializeDateFormatting(user?.settings.language.language ?? "es_AR");
          if (isFirstTime) {
            return context.go(AppRoutes.onboarding);
          }

          final time = DateTime.now().millisecondsSinceEpoch;
          await provider.updateLastConnectionTime(userId: user!.id, time: time);

          if (user.type == UserType.user) {
            ref.read(patientNotifier.notifier).setUser(user.patient);
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
                "global.hello".trl,
                style: textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: const AssetImage(AppImages.kLogoOttaa),
              width: size.width * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
