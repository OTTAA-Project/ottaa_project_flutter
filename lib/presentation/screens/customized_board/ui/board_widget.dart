import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.customizeOnTap,
    required this.deleteOnTap,
    required this.onChanged,
    required this.status,
  }) : super(key: key);
  final String title;
  final ImageProvider image;
  final void Function()? customizeOnTap, deleteOnTap;
  final Function(bool)? onChanged;
  final bool status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: image,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title.length >= 21 ? '${title.substring(0, 21)}...' : title,
                    style: textTheme.subtitle2!.copyWith(
                        // overflow: TextOverflow.ellipsis,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: customizeOnTap,
                    child: Image.asset(
                      AppImages.kCustomizePictoIcon,
                      height: 10,
                      width: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: deleteOnTap,
                    child: Image.asset(
                      AppImages.kDeletePictoIcon,
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1,
              color: colorScheme.background,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "customize.picto.switch".trl,
                style: textTheme.subtitle2,
              ),
              OTTAASwitch(
                value: status,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
