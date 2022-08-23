import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MobileImageWidget extends StatelessWidget {
  const MobileImageWidget({
    Key? key,
    required this.isEditing,
    required this.imageName,
    this.fileImage,
    this.selectedImageUrl,
  }) : super(key: key);
  final bool isEditing;
  final String imageName;
  final File? fileImage;
  final String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? selectedImageUrl == ''
            ? Image.file(fileImage!)
            : Image.network(selectedImageUrl!)
        : CachedNetworkImage(
            imageUrl: imageName,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            fit: BoxFit.fill,
          );
  }
}
