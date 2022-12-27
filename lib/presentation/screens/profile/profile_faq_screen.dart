import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/faq_container_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileFAQScreen extends StatefulWidget {
  const ProfileFAQScreen({Key? key}) : super(key: key);

  @override
  State<ProfileFAQScreen> createState() => _ProfileFAQScreenState();
}

class _ProfileFAQScreenState extends State<ProfileFAQScreen> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    //todo: add the theme here
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text("profile.faq.title".trl),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) => FaqContainerWidget(
                    selected: true,
                    //todo: add the proper term here
                    heading: "faq1".trl,
                    subtitle: "faq1Description",
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });
                    },
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
