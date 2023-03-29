import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/loading_modal.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/category_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_photo_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileSettingsScreen extends ConsumerWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userNotifier);
    final auth = ref.read(authProvider);
    final provider = ref.watch(profileProvider);
    return Scaffold(
      // sorry for doing this, emir helped me in making it better
      appBar: OTTAAAppBar(
        title: Text(
          "profile.profile".trl,
        ),
        actions: [
          Image.asset(
            AppImages.kLogoOttaa,
            height: 36,
            width: 116,
            fit: BoxFit.cover,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilePhotoWidget(
                  image: user?.settings.data.avatar.network ?? "",
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  user?.settings.data.name ?? "",
                ),
                const SizedBox(
                  height: 32,
                ),
                CategoryWidget(
                  onTap: () => context.push(AppRoutes.profileSettingsEditScreen),
                  icon: AppImages.kProfileSettingsIcon1,
                  text: "profile.profile".trl,
                ),
                provider.isUser
                    ? Container()
                    : CategoryWidget(
                        onTap: () =>
                            context.push(AppRoutes.profileChooserScreenSelected),
                        icon: AppImages.kProfileSettingsIcon2,
                        text: "profile.role".trl,
                      ),
                CategoryWidget(
                  onTap: () => context.push(AppRoutes.profileHelpScreen),
                  icon: AppImages.kProfileSettingsIcon3,
                  text: "profile.help.help".trl,
                ),
                provider.isUser
                    ? Container()
                    : CategoryWidget(
                        onTap: () =>
                            context.push(AppRoutes.profileLinkedAccountScreen),
                        icon: AppImages.kProfileSettingsIcon4,
                        text: "profile.linked_accounts".trl,
                      ),
                CategoryWidget(
                  onTap: () => context.push(AppRoutes.profileOttaaTips),
                  icon: AppImages.kProfileSettingsIcon5,
                  text: "profile.ottaa.tips".trl,
                ),
                CategoryWidget(
                  divider: false,
                  onTap: () async {
                    await LoadingModal.show(context, future: auth.logout);
                    context.go(AppRoutes.login);
                  },
                  icon: null,
                  text: "profile.logout".trl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
