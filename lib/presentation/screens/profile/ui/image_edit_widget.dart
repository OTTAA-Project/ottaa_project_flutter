import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class ImageEditWidget extends StatelessWidget {
  const ImageEditWidget({
    Key? key,
    required this.imageUrl,
    required this.imageSelected,
    required this.imagePath,
    required this.cameraOnTap,
    required this.galleryOnTap,
  }) : super(key: key);
  final String imageUrl, imagePath;
  final bool imageSelected;
  final void Function()? cameraOnTap, galleryOnTap;

  @override
  Widget build(BuildContext context) {
    //todo: add the proper theme here
    return SizedBox(
      height: 170,
      width: 170,
      child: Stack(
        children: [
          GestureDetector(
            onTap: cameraOnTap,
            child: Container(
              height: 160,
              width: 160,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: imageSelected
                  ? (kIsWeb
                      ? Image.network(
                          imagePath,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(imagePath),
                          fit: BoxFit.fill,
                        ))
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: galleryOnTap,
              child: Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFB5B6B8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.photo_library_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
