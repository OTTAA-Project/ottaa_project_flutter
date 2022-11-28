import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/new_simple_button.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_chooser_button_widget.dart';

class ProfileChooserScreen extends StatelessWidget {
  const ProfileChooserScreen({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    //todo: add text style here after emir has created the theme files
                    child: Text(
                      'profile.omitir'.trl,
                    ),
                  ),
                  //todo: add text style here after emir has created the theme files
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 36,
                      bottom: 24,
                    ),
                    child: Text(
                      'profile.selection.text1'.trl,
                    ),
                  ),
                  ProfileChooserButtonWidget(
                    heading: 'profile.acompanante'.trl,
                    subtitle: 'profile.profesionales.familiares'.trl,
                    imagePath: AppImages.kProfileIcon1,
                    onTap: () {},
                    selected: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ProfileChooserButtonWidget(
                    heading: 'profile.acompanante'.trl,
                    subtitle: 'profile.necesita.comunicarse'.trl,
                    imagePath: AppImages.kProfileIcon2,
                    onTap: () {},
                    selected: false,
                  ),
                ],
              ),
              NewSimpleButton(
                onTap: () {},
                active: false,
                text: "profile.continuar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
