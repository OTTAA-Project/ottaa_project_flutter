import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
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
                        "profile.perfil".trl,
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
                "UserName will be here",
              ),
              const SizedBox(
                height: 32,
              ),
              CategoryWidget(
                onTap: () {},
                icon: AppImages.kProfileSettingsIcon1,
                text: "profile.perfil".trl,
              ),
              CategoryWidget(
                onTap: () {},
                icon: AppImages.kProfileSettingsIcon2,
                text: "profile.rol.de.uso".trl,
              ),
              CategoryWidget(
                onTap: () {},
                icon: AppImages.kProfileSettingsIcon3,
                text: "profile.ayuda".trl,
              ),
              CategoryWidget(
                onTap: () {},
                icon: AppImages.kProfileSettingsIcon4,
                text: "profile.cuentas.vinculadas".trl,
              ),
              CategoryWidget(
                onTap: () {},
                icon: AppImages.kProfileSettingsIcon5,
                text: "profile.ottaa.tips".trl,
              ),
              Text("profile.cerrar.sesión".trl),
            ],
          ),
        ),
      ),
    );
  }
}
