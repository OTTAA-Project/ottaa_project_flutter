import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/faq_container_widget.dart';

class ProfileFAQScreen extends StatelessWidget {
  const ProfileFAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo: add the theme here
    return Scaffold(
      backgroundColor: kOTTAABackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 46,
                  bottom: 38,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      "profile.faq.title".trl,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) => FaqContainerWidget(
                    selected: false,
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
