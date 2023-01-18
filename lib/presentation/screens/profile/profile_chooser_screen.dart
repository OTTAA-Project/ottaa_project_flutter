import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileChooserScreen extends ConsumerWidget {
  const ProfileChooserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final provider = ref.watch(profileProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 36,
                      bottom: 24,
                    ),
                    child: Text(
                      'profile.selection.text1'.trl,
                      style: textTheme.headline2,
                    ),
                  ),
                  ActionCard(
                    title: 'profile.caregiver'.trl,
                    subtitle: 'profile.caregivers_families'.trl,
                    trailingImage: const AssetImage(AppImages.kProfileIcon1),
                    onPressed: () {
                      provider.isCaregiver = !provider.isCaregiver;
                      provider.isUser = false;
                      provider.notify();
                    },
                    focused: provider.isCaregiver,
                    imageSize: const Size(129, 96),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ActionCard(
                    title: 'profile.user'.trl,
                    subtitle: 'profile.user_description'.trl,
                    trailingImage: const AssetImage(AppImages.kProfileIcon2),
                    onPressed: () {
                      provider.isUser = !provider.isUser;
                      provider.isCaregiver = false;
                      provider.notify();
                    },
                    focused: provider.isUser,
                    imageSize: const Size(129, 96),
                  ),
                ],
              ),
              PrimaryButton(
                //todo: add the proper way for handling the waiting screen, hector said is should be their for 4 seconds at least
                onPressed: (provider.isCaregiver || provider.isUser) ? () => context.push(AppRoutes.profileWaitingScreen) : null,
                text: "global.continue".trl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
