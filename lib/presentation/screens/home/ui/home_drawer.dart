import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/service/sql_database.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/loading_modal.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final auth = ref.read(authProvider.notifier);
    final userAvatar = ref.watch(userAvatarNotifier);

    return SafeArea(
      child: Drawer(
        width: width / 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: height * 0.15,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: kOTTAAOrangeNew,
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.onboarding, extra: 2),
                        child: Image.asset(
                          'assets/profiles/Group $userAvatar@2x.png',
                          height: height * 0.05,
                        ),
                      ),
                      Image.asset(
                        AppImages.kWhiteLogoOttaa,
                        height: height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('Ubicación'.trl),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.volume_up), //TODO*: Toggle between Icons.volume_up and Icons.volume_off
              title: Text('mute'.trl),
              onTap: () {
                // Use tts provider to mute or unmute
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('about_ottaa'.trl),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_kanban_outlined),
              title: Text('report'.trl),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('configuration'.trl),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('tutorial'.trl),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.highlight_remove),
              title: Text('close_application'.trl),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text('sign_out'.trl),
              onTap: () async {
                await LoadingModal.show(context, future: auth.logout);
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
