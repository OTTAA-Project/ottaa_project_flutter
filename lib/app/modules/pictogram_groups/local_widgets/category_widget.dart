import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'icon_widget.dart';
import 'dart:io';

final Map<int, Color> groupColor = {
  1: Colors.yellow,
  2: kOTTAAOrange,
  3: Colors.green,
  4: Colors.blue,
  5: Colors.purple,
  6: Colors.black,
};

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
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
    this.names,
  }) : super(key: key);
  final Texto name;
  TextoGrupos? names;
  final String imageName;
  final bool border;
  final int color;
  final bool bottom;
  final String languaje;
  final bool isEditing;
  final File? fileImage;
  Image? imageWidget;

  // url for arsaac images
  String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    String text;
    if (names == null) {
      switch (this.languaje) {
        case "es-AR":
          text = name.es;
          break;
        case "en-US":
          text = name.en;
          break;
        case "fr-FR":
          text = name.fr;
          break;
        case "pt-BR":
          text = name.pt;
          break;
        default:
          text = name.es;
      }
    } else {
      switch (this.languaje) {
        case "es-AR":
          text = names!.es;
          break;
        case "en-US":
          text = names!.en;
          break;
        case "fr-FR":
          text = names!.fr;
          break;
        case "pt-BR":
          text = names!.pt;
          break;
        default:
          text = names!.es;
      }
    }
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
                        color: groupColor[color]!,
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
                  : DeviceImageWidget(
                      isEditing: isEditing,
                      imageName: imageName,
                      fileImage: fileImage,
                      selectedImageUrl: selectedImageUrl,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalSize * 0.01),
            //filler for the text
            child: Text(
              text.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w700,
              fontSize: verticalSize * 0.035,
              ),
            ),
          ),
          bottom
              ? Padding(
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
              : Container(),
        ],
      ),
    );
  }
}

class WebImageWidget extends StatelessWidget {
  WebImageWidget({
    Key? key,
    required this.isEditing,
    required this.imageName,
    this.imageWidget,
    this.selectedImageUrl,
  }) : super(key: key);
  final bool isEditing;
  final String imageName;
  Image? imageWidget;
  String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? imageWidget == null
            ? Image.network(
                selectedImageUrl == '' ? imageName : selectedImageUrl!,
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
              )
            : imageWidget!
        : Image.network(
            selectedImageUrl == '' ? imageName : selectedImageUrl!,
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

class DeviceImageWidget extends StatelessWidget {
  DeviceImageWidget({
    Key? key,
    required this.isEditing,
    required this.imageName,
    this.fileImage,
    this.selectedImageUrl,
  }) : super(key: key);
  final bool isEditing;
  final String imageName;
  File? fileImage;
  String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? selectedImageUrl == ''
            ? Image.file(fileImage!)
            : Image.network(selectedImageUrl!)
        : CachedNetworkImage(
            imageUrl: imageName,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            fit: BoxFit.fill,
          );
  }
}
