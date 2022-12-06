import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_chooser_button_widget.dart';

class ProfileHelpScreen extends StatelessWidget {
  const ProfileHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo: add the color here
      backgroundColor: kOTTAABackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      "profile.ayuda".trl,
                    ),
                  ],
                ),
              ),
              ProfileChooserButtonWidget(
                heading: "profile.help.title1".trl,
                subtitle: '',
                imagePath: AppImages.kProfileHelpIcon1,
                onTap: () => context.push(AppRoutes.profileFAQScreen),
                selected: false,
              ),
              const SizedBox(
                height: 16,
              ),
              ProfileChooserButtonWidget(
                heading: "profile.help.title2".trl,
                subtitle: '',
                imagePath: AppImages.kProfileHelpIcon2,
                onTap: () {},
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
