import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/new_simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_chooser_button_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileChooserScreenSelected extends StatelessWidget {
  const ProfileChooserScreenSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text("profile.role".trl),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 24,
                    ),
                    child: Text(
                      "profile.chooser.screen.heading".trl,
                    ),
                  ),
                  ProfileChooserButtonWidget(
                    heading: 'profile.caregiver'.trl,
                    subtitle: 'profile.caregivers_families'.trl,
                    imagePath: AppImages.kProfileIcon1,
                    onTap: () {},
                    selected: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ProfileChooserButtonWidget(
                    heading: 'profile.user'.trl,
                    subtitle: 'profile.necesita.comunicarse'.trl,
                    imagePath: AppImages.kProfileIcon2,
                    onTap: () {},
                    selected: false,
                  ),
                ],
              ),
              const Spacer(),
              PrimaryButton(
                //todo: add the proper way for handling the waiting screen, hector said is should be their for 4 seconds at least
                onPressed: () => context.push(AppRoutes.profileWaitingScreen),
                enabled: false,
                text: "profile.chooser.screen.button".trl,
              ),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
