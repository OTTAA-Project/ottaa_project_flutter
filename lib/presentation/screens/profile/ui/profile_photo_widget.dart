import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({Key? key, required this.image, this.height = 32, this.width = 32, this.asset = '671'}) : super(key: key);
  final String image, asset;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kOTTAAOrangeNew, width: height / 32),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      height: height,
      width: width,
      // padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: image.isEmpty
                ? Image.asset('assets/profiles/Group $asset@2x.png')
                : CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: image,
                  ),
          ),
        ],
      ),
    );
  }
}
