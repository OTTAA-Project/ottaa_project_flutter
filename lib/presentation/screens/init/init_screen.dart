import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';

import '../../../application/router/app_routes.dart';

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    SplashProvider provider = ref.read(splashProvider);

    final auth = ref.read(authNotifier.notifier);
    await blockPortraitMode();

    setState(() {});

    bool isLogged = await provider.fetchUserInformation();
    bool isFirstTime = await provider.isFirstTime();

    if (isLogged) {
      final user = ref.read(userNotifier);
      auth.setSignedIn();
      await I18N.of(context).changeLanguage(user?.settings.language.language ?? "es_AR");
      if (mounted) {
        if (isFirstTime) {
          return context.go(AppRoutes.onboarding);
        }

        if (user!.type == UserType.caregiver) {
          return context.go(AppRoutes.profileMainScreen);
        } else {
          final time = DateTime.now().millisecondsSinceEpoch;
          provider.updateLastConnectionTime(userId: user.id, time: time);
          ref.read(patientNotifier.notifier).setUser(user.patient);
          return context.go(AppRoutes.profileMainScreenUser);
        }
      }
    }
    if (mounted) return context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
