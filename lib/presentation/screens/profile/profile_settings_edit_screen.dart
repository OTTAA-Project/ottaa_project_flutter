import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/new_simple_button.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/new_text_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/date_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/image_edit_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileSettingsEditScreen extends StatelessWidget {
  const ProfileSettingsEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text("profile.profile".trl),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ImageEditWidget(
                      image: AppImages.kTestImage,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  OTTAATextInput(
                    hintText: 'profile.name'.trl,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: OTTAATextInput(
                      hintText: 'profile.last_name'.trl,
                    ),
                  ),
                  OTTAATextInput(
                    hintText: 'profile.mail'.trl,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    child: Text(
                      "profile.date".trl,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DateWidget(
                        text: 'profile.day'.trl,
                        onTap: () {},
                      ),
                      DateWidget(
                        text: 'profile.month'.trl,
                        onTap: () {},
                      ),
                      DateWidget(
                        text: 'profile.year'.trl,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              NewSimpleButton(
                onTap: () {},
                text: 'Continuar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
