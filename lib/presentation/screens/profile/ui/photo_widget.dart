import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kOTTAAOrangeNew, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      height: 32,
      width: 32,
      // padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              fit: BoxFit.contain, imageUrl: image,
              // height: 90,
              // width: 90,
            ),
          ),
        ],
      ),
    );
  }
}
