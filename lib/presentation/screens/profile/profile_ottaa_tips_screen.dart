import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/tips_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileOTTAATipsScreen extends StatelessWidget {
  const ProfileOTTAATipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          "profile.ottaa.tips".trl,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => TipsWidget(
                    subtitle: "faq{$index}s".trl,
                    title: 'faq{$index}'.trl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
