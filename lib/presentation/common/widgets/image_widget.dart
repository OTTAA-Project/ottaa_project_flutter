import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return FadeInImage.memoryNetwork(
        image: url,
        placeholder: kTransparentImage,
        fit: BoxFit.fill,
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.fill,
    );
  }
}
