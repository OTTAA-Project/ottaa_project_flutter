import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';

/*class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final provider = ref.watch(splashProvider);
    // FutureBuilder
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
}*/

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    SplashProvider provider = ref.read(splashProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bool hasPhoto = await provider.checkUserAvatar();

      if (mounted) {
        if (!hasPhoto) {
          //TODO: Send to select Avatar
          /// avatar screen is at the third, 2 index for the pageviewer.
          // Navigator.popAndPushNamed(context, AppRoutes.ONBOARDING);

          //Index of the avatar screen at the extra option
          context.go(AppRoutes.onboarding, extra: 2);
          return;
        }

        context.go(AppRoutes.home);
      }

      return;
    });

    super.initState();
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
