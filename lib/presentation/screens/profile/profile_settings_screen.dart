import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/category_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_photo_widget.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo: add the required theme here
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "profile.profile".trl,
                      ),
                    ],
                  ),
                  Image.asset(
                    AppImages.kProfileOttaalogo,
                    height: 36,
                    width: 116,
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              //todo: add the image link here
              const ProfilePhotoWidget(
                image: AppImages.kTestImage,
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "global.hello_world".trl,
              ),
              const SizedBox(
                height: 32,
              ),
              CategoryWidget(
                onTap: () => context.push(AppRoutes.profileSettingsEditScreen),
                icon: AppImages.kProfileSettingsIcon1,
                text: "profile.profile".trl,
              ),
              CategoryWidget(
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
              CategoryWidget(
                onTap: () {},
                icon: AppImages.kProfileSettingsIcon4,
                text: "profile.linked_accounts".trl,
              ),
              CategoryWidget(
                onTap: () => context.push(AppRoutes.profileOttaaTips),
                icon: AppImages.kProfileSettingsIcon5,
                text: "profile.ottaa.tips".trl,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "profile.logout".trl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
