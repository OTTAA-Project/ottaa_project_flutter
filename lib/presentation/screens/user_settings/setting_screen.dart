import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_user_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class SettingScreenUser extends StatelessWidget {
  const SettingScreenUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'profile.settings'.trl,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ProfileUserWidget(
              title: 'user.settings.main_screen'.trl,
              onTap: () {},
            ),
            ProfileUserWidget(
              title: 'user.settings.accessibility'.trl,
              onTap: () {},
            ),
            ProfileUserWidget(
              title: 'user.settings.voice_and_subtitles'.trl,
              onTap: () {},
            ),
            ProfileUserWidget(
              title: 'user.settings.language'.trl,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
