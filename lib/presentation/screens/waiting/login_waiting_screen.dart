import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_loading_animation.dart';

class LoginWaitingScreen extends ConsumerStatefulWidget {
  const LoginWaitingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWaitingScreenState();
}

class _LoginWaitingScreenState extends ConsumerState<LoginWaitingScreen> {
  @override
  void initState() {
    SplashProvider provider = ref.read(splashProvider);

    final localContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.fetchUserInformation();

      if (mounted) localContext.go(AppRoutes.profileChooserScreen);
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
              "Te damos la bienvenida",
              style: textTheme.headline2,
            ),
            const SizedBox(height: 10),
            Text(
              "Al nuevo Mundo de OTTAA Project",
              style: textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
