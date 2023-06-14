import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:picto_widget/picto_widget.dart';

class CreatePictogramInitialScreen extends ConsumerWidget {
  const CreatePictogramInitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'create.image_selection'.trl,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 32,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: size.height * 0.2,
            height: size.height * 0.25,
            child: FittedBox(
              fit: BoxFit.fill,
              child: PictoWidget(
                image: Image.asset(AppImages.kAddIcon),
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
                                onTap: () {
                                  //todo: open the camera from here
                                },
                              ),
                            ),
                            DialogWidget(
                              image: AppImages.kGalleryIcon,
                              text: 'global.gallery'.trl,
                              onTap: () {
                                //todo: open the gallery from here
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                text: 'global.add'.trl,
              ),
            ),
          ),
        ),
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
