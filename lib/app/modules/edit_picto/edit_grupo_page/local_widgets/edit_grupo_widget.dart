import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../../../theme/app_theme.dart';

class EditGrupoWidget extends StatelessWidget {
  const EditGrupoWidget({
    Key? key,
    required this.name,
    required this.mainNativeImageUrl,
    this.selectedImageUrl,
    this.imageWidget,
    this.fileImage,
    required this.editingGrupo,
  }) : super(key: key);
  final String name;
  final String mainNativeImageUrl;
  final String? selectedImageUrl;
  final File? fileImage;
  final Image? imageWidget;
  final bool editingGrupo;

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
          left: horizontalSize * 0.01,
          right: horizontalSize * 0.01,
          // bottom: horizontalSize * 0.01,
          top: horizontalSize * 0.01),
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
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: kIsWeb
                  ? WebImage(
                      selectedImageUrl: selectedImageUrl,
                      mainNativeImageUrl: mainNativeImageUrl,
                      imageWidget: imageWidget,
                    )
                  : DeviceImage(
                      selectedImageUrl: selectedImageUrl,
                      fileImage: fileImage,
                      mainNativeImageUrl: mainNativeImageUrl,
                      editingGrupo: editingGrupo,
                    ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: TextStyle(fontSize: verticalSize * 0.03, fontWeight: FontWeight.w600),
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
    required this.mainNativeImageUrl,
    this.selectedImageUrl,
    this.imageWidget,
  }) : super(key: key);
  final String? selectedImageUrl;
  final Image? imageWidget;
  final String mainNativeImageUrl;

  @override
  Widget build(BuildContext context) {
    return imageWidget != null
        ? imageWidget!
        : selectedImageUrl == ''
            ? Image.network(
                mainNativeImageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: kOTTAAOrangeNew,
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  );
                },
              )
            : Image.network(
                selectedImageUrl!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: kOTTAAOrangeNew,
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  );
                },
              );
  }
}

class DeviceImage extends StatelessWidget {
  const DeviceImage({
    Key? key,
    required this.mainNativeImageUrl,
    this.selectedImageUrl,
    this.fileImage,
    required this.editingGrupo,
  }) : super(key: key);
  final String? selectedImageUrl;
  final File? fileImage;
  final String mainNativeImageUrl;
  final bool editingGrupo;

  @override
  Widget build(BuildContext context) {
    return !editingGrupo
        ? Image.network(mainNativeImageUrl)
        : selectedImageUrl == ''
            ? Image.file(fileImage!)
            : Image.network(selectedImageUrl!);
  }
}
