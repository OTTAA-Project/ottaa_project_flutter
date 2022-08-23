import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/platform/mobile_web_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/platform/web_image_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/theme/group_colors.dart';
import 'icon_widget.dart';
import 'dart:io';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.name,
    required this.imageName,
    this.border = false,
    this.bottom = true,
    this.color = 0,
    this.languaje = '',
    this.isEditing = false,
    this.fileImage,
    this.imageWidget,
    this.selectedImageUrl = '',
  }) : super(key: key);
  final String name;
  final String imageName;
  final bool border;
  final int color;
  final bool bottom;
  final String languaje;
  final bool isEditing;
  final File? fileImage;
  final Image? imageWidget;

  // url for arsaac images
  final String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    // String text;
    //
    // switch (this.languaje) {
    //   case "es-US":
    //     text = texto.es;
    //     break;
    //   case "en-US":
    //     text = texto.en;
    //     break;
    //
    //   default:
    //     text = texto.es;
    // }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          //placeholder for the photos
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: border
                    ? Border.all(
                        color: kGroupColor[color]!,
                        width: 6,
                      )
                    : Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: kIsWeb
                  ? WebImageWidget(
                      isEditing: isEditing,
                      imageName: imageName,
                      imageWidget: imageWidget,
                      selectedImageUrl: selectedImageUrl,
                    )
                  : MobileImageWidget(
                      isEditing: isEditing,
                      imageName: imageName,
                      fileImage: fileImage,
                      selectedImageUrl: selectedImageUrl,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            //filler for the text
            child: Text(
              name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          if (bottom)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  IconWidget(icon: Icons.timer_off),
                  IconWidget(icon: Icons.location_off),
                  IconWidget(icon: Icons.face),
                  IconWidget(icon: Icons.wc),
                ],
              ),
            )
        ],
      ),
    );
  }
}
