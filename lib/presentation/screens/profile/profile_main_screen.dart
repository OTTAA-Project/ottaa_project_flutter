import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/drop_down_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_photo_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_chooser_button_widget.dart';

bool change = true;

class ProfileMainScreen extends StatelessWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  //todo: a jojo reference XD
  final String userName = 'Dio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo: add the theme here
      backgroundColor: kOTTAABackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //todo: add the link here to go to the profile setting screen
                      GestureDetector(
                        onTap: () =>
                            context.push(AppRoutes.profileSettingsScreen),
                        child: const ProfilePhotoWidget(
                          //todo: add the image link here, from the userData
                          image: AppImages.kTestImage,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      //todo: replace it with the name from the userData
                      Text(
                        '${"profile.hola".trl} $userName!',
                      ),
                    ],
                  ),
                  Image.asset(
                    AppImages.kNotificationIcon,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "profile.qué.deseas.hacer".trl,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ProfileChooserButtonWidget(
                  subtitle: "profile.nuevo.existente".trl,
                  selected: !change,
                  heading: "profile.agregar.cuenta".trl,
                  imagePath: AppImages.kProfileMainScreenIcon,
                  onTap: () {
                    change = !change;
                  },
                ),
              ),
              //todo: add the trigger here for the container to show and hide
              AnimatedContainer(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                duration: const Duration(milliseconds: 500),
                height: change ? 0 : 140,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      DropDownWidget(
                        onTap: () {},
                        image: AppImages.kProfileAddIcon,
                        text: "profile.crear.nueva.cuenta".trl,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropDownWidget(
                        onTap: () {},
                        image: AppImages.kProfileLinkIcon,
                        text: "profile.vincular.con.cuenta".trl,
                      ),
                    ],
                  ),
                ),
              ),
              ProfileChooserButtonWidget(
                subtitle: "profile.modo.sin.perfil".trl,
                selected: false,
                heading: "profile.usar.ottaa".trl,
                imagePath: AppImages.kProfileIcon2,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
