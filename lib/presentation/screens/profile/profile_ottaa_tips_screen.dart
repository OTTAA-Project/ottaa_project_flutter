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
      backgroundColor: kOTTAABackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            children: [
              //todo: emir will fix it
              OTTAAAppBar(
                title: Text(
                  "profile.ottaa.tips".trl,
                ),
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
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
