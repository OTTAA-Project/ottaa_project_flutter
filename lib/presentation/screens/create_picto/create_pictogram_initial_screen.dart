import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/text_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/widgets/image_widget.dart';
import 'package:picto_widget/picto_widget.dart';

class CreatePictogramInitialScreen extends ConsumerWidget {
  const CreatePictogramInitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final provider = ref.watch(createPictoProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'create.image_selection'.trl,
                style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 32,
              ),
              ImageWidget(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        content: Row(
                          children: [
                            DialogWidget(
                              image: AppImages.kArsacImage,
                              text: 'global.arasaac'.trl,
                              onTap: () {
                                //todo: do the arsaac from here
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: DialogWidget(
                                image: AppImages.kCameraIcon,
                                text: 'shortcut.customize.camera'.trl,
                                onTap: () async {
                                  final res = await provider.captureImageFromCamera();
                                  if (res) {
                                    context.pop();
                                    provider.notify();
                                  }
                                },
                              ),
                            ),
                            DialogWidget(
                              image: AppImages.kGalleryIcon,
                              text: 'global.gallery'.trl,
                              onTap: () async {
                                final res = await provider.captureImageFromGallery();
                                if (res) {
                                  context.pop();
                                  provider.notify();
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
              provider.isImageSelected ? const TextWidget() : const SizedBox.shrink(),
            ],
          ),
        ),

        ///todo: add here for name length check
        if (provider.nameController.text.length >= 2) ...[
          SimpleButton(
            width: false,
            onTap: () {
              provider.nextPage();
            },
            text: 'global.next'.trl,
          ),
          const SizedBox(
            height: 16,
          ),
        ]
      ],
    );
  }
}

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  final String image, text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 92,
        // height: 130,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: AutoSizeText(
                text.toUpperCase(),
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
