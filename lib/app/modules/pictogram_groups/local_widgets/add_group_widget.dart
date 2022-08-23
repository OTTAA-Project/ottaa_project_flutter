import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/theme/group_colors.dart';
import 'dart:io';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class AddGroupWidget extends StatelessWidget {
  const AddGroupWidget({
    Key? key,
    required this.name,
    required this.isImageProvided,
    this.selectedImageUrl,
    this.imageWidget,
    this.fileImage,
    required this.color,
  }) : super(key: key);

  final String name;
  final bool isImageProvided;
  final String? selectedImageUrl;
  final File? fileImage;
  final Image? imageWidget;
  final int color;

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
        left: horizontalSize * 0.01,
        top: horizontalSize * 0.01,
        right: horizontalSize * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(verticalSize * 0.03),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.pink,
                borderRadius: BorderRadius.circular(verticalSize * 0.02),
                border: Border.all(color: kGroupColor[color]!, width: 4),
              ),
              child: isImageProvided
                  ? kIsWeb
                      ? WebImage(
                          selectedImageUrl: selectedImageUrl,
                          imageWidget: imageWidget,
                        )
                      : DeviceImage(
                          selectedImageUrl: selectedImageUrl,
                          fileImage: fileImage,
                        )
                  : Center(
                      child: Image.asset('assets/imgs/ic_agregar_nuevo.webp'),
                    ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                    fontSize: verticalSize * 0.03, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WebImage extends StatelessWidget {
  const WebImage({
    Key? key,
    this.selectedImageUrl,
    this.imageWidget,
  }) : super(key: key);
  final String? selectedImageUrl;
  final Image? imageWidget;

  @override
  Widget build(BuildContext context) {
    return imageWidget != null
        ? imageWidget!
        : Image.network(
            selectedImageUrl!,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: kOTTAAOrangeNew,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          );
  }
}

class DeviceImage extends StatelessWidget {
  const DeviceImage({
    Key? key,
    this.selectedImageUrl,
    this.fileImage,
  }) : super(key: key);
  final String? selectedImageUrl;
  final File? fileImage;

  @override
  Widget build(BuildContext context) {
    return selectedImageUrl == ''
        ? Image.file(fileImage!)
        : Image.network(selectedImageUrl!);
  }
}
