import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_loading_animation.dart';

class LoginWaitingScreen extends ConsumerStatefulWidget {
  const LoginWaitingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWaitingScreenState();
}

const Map<UserType, String> _userTypeRoutes = {
  UserType.caregiver: AppRoutes.profileMainScreen,
  UserType.user: AppRoutes.profileMainScreenUser,
  UserType.none: AppRoutes.profileChooserScreen,
};

class _LoginWaitingScreenState extends ConsumerState<LoginWaitingScreen> {
  @override
  void initState() {
    SplashProvider provider = ref.read(splashProvider);

    final localContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.fetchUserInformation();

      bool isFirstTime = await provider.isFirstTime();

      final user = ref.read(userNotifier);

      await I18N.of(context).changeLanguage(user?.settings.language ?? "en_US");
      if (mounted) {

        if (isFirstTime) {
          return localContext.go(AppRoutes.onboarding);
        }

        localContext.go(_userTypeRoutes[user!.type]!);
      }
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
              "login.wait.title".trl,
              style: textTheme.headline2,
            ),
            const SizedBox(height: 10),
            Text(
              "login.wait.subtitle",
              style: textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
