import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/image_edit_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileSettingsEditScreen extends ConsumerStatefulWidget {
  const ProfileSettingsEditScreen({super.key});

  @override
  ConsumerState<ProfileSettingsEditScreen> createState() => _ProfileSettingsEditScreenState();
}

class _ProfileSettingsEditScreenState extends ConsumerState<ProfileSettingsEditScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = ref.read(profileProvider);
      provider.setDate();
      final user = ref.read(userNotifier);
      final data = user!.settings.data;
      provider.profileEditNameController.text = data.name;
      provider.profileEditSurnameController.text = data.lastName;
      provider.profileEditEmailController.text = user.email;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    final provider = ref.watch(profileProvider);
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    final user = ref.watch(userNotifier);
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          leading: GestureDetector(
            onTap: () {
              provider.imageSelected = false;
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "profile.profile".trl,
              style: textTheme.displaySmall,
            ),
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
                        cameraOnTap: () => provider.pickImage(cameraOrGallery: true),
                        galleryOnTap: () => provider.pickImage(cameraOrGallery: false),
                        imagePath: provider.profileEditImage != null ? provider.profileEditImage!.path : "",
                        imageSelected: provider.imageSelected,
                        imageUrl: user?.settings.data.avatar.network ?? AppImages.kTestImage,
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
                      isReadOnly: true,
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
                        //days
                        Expanded(
                          child: OTTAADropdown<String>(
                            selected: provider.day.toString(),
                            onChanged: (String? a) {
                              provider.day = int.parse(a!);
                              provider.notify();
                              print("day is $a");
                            },
                            items: List.generate(
                              32,
                              (index) => (index).toString(),
                            ),
                            label: (String item) => Text(
                              item,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        //months
                        Expanded(
                          child: OTTAADropdown<String>(
                            selected: provider.month.toString(),
                            onChanged: (String? a) {
                              provider.month = int.parse(a!);
                              provider.notify();
                              print("month is $a");
                            },
                            items: List.generate(
                              13,
                              (index) => index.toString(),
                            ),
                            label: (String item) => Text(
                              item,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: OTTAADropdown<String>(
                            selected: provider.year.toString(),
                            onChanged: (String? a) {
                              provider.year = int.parse(a!);
                              provider.notify();
                            },
                            items: List.generate(
                              80,
                              (index) => (currentYear - index).toString(),
                            ),
                            label: (String item) => Text(
                              item,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PrimaryButton(
                  onPressed: () async {
                    await provider.updateChanges();

                    /// reset to get new image
                    provider.imageSelected = false;
                    context.pop();
                  },
                  text: 'global.continue'.trl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
