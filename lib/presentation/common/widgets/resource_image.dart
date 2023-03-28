import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';

class ResourceImage extends StatelessWidget {
  final double? width;
  final double? height;

  final AssetsImage image;

  final BoxFit boxFit;

  const ResourceImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (image.network != null) {
      return CachedNetworkImage(
        imageUrl: image.network!,
        fit: boxFit,
        width: width,
        height: height,
        errorWidget: (context, url, error) => Image.asset(
          fit: BoxFit.fill,
          "assets/img/${image.asset}.webp",
        ),
      );
    }
    return Image.asset(
      fit: boxFit,
      width: width,
      height: height,
      "assets/img/${image.asset}.webp",
    );
  }
}
