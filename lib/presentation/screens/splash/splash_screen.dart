import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';

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
      print(isLogged);
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/imgs/logo_ottaa.webp'),
          ),
          const LinearProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 10),
          Text("we_are_preparing_everything".trl)
        ],
      ),
    );
  }
}
