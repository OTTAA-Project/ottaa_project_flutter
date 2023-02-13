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
      body: Column(
        children: [
          ProfileUserWidget(
            title: ''.trl,
            onTap: () {},
          ),
          ProfileUserWidget(
            title: ''.trl,
            onTap: () {},
          ),
          ProfileUserWidget(
            title: ''.trl,
            onTap: () {},
          ),
          ProfileUserWidget(
            title: ''.trl,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
