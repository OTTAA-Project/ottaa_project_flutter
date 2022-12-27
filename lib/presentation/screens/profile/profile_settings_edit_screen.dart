import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/date_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/image_edit_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileSettingsEditScreen extends ConsumerWidget {
  const ProfileSettingsEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(profileProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.watch(userNotifier);
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          "profile.profile".trl,
          style: textTheme.headline3,
        ),
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
                      cameraOnTap: () =>
                          provider.pickImage(cameraOrGallery: true),
                      galleryOnTap: () =>
                          provider.pickImage(cameraOrGallery: false),
                      imagePath: provider.profileEditImage != null
                          ? provider.profileEditImage!.path
                          : "",
                      imageSelected: provider.imageSelected,
                      imageUrl: user?.photoUrl ?? AppImages.kTestImage,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  OTTAATextInput(
                    hintText: 'profile.name'.trl,
                    controller: provider.profileEditNameController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: OTTAATextInput(
                      hintText: 'profile.last_name'.trl,
                      controller: provider.profileEditSurnameController,
                    ),
                  ),
                  OTTAATextInput(
                    hintText: 'profile.mail'.trl,
                    controller: provider.profileEditEmailController,
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
              PrimaryButton(
                onPressed: () {},
                text: 'global.continue'.trl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
