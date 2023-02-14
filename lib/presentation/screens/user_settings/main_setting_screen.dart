import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class MainSettingScreen extends StatelessWidget {
  const MainSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'user.settings.main_screen'.trl,
          style: textTheme.headline3,
        ),
      ),
      body: Column(
        children: [
          Text(
            'user.main_setting.interaction'.trl,
            style: textTheme.headline2!.copyWith(
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
