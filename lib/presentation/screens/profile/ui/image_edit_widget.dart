import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageEditWidget extends StatelessWidget {
  const ImageEditWidget({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    //todo: add the proper theme here
    return SizedBox(
      height: 170,
      width: 170,
      child: Stack(
        children: [
          Container(
            height: 160,
            width: 160,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: true
                ? const Center(
                    child: Text(
                      'MP',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                  ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
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
        ],
      ),
    );
  }
}
