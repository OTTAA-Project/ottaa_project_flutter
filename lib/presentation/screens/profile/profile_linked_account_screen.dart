import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileLinkedAccountScreen extends StatelessWidget {
  const ProfileLinkedAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              //todo: why it is giving the error Emir-Chan
              OTTAAAppBar(
                title: Text(
                  "profile.help.help".trl,
                ),
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              //todo: discuss the last text with the hector
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: const ProfileCard(
                      title: 'Juan Varela',
                      subtitle: 'Usuario',
                      actions: Text('Text to be added'),
                      leadingImage: NetworkImage(
                        'https://cdn.discordapp.com/avatars/854381699559718922/517e6e3900959a7a4bb89f3b16dab238.png?size=1024',
                      ),
                    ),
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
