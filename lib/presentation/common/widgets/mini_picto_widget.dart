import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

class MiniPicto extends StatelessWidget {
  final Picto pict;
  final VoidCallback onTap;
  final bool localImg;

  const MiniPicto({super.key, 
    required this.pict,
    required this.onTap,
    required this.localImg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: localImg
              ? Image(
                  image: AssetImage(
                    'assets/imgs/${pict.resource.asset}.webp',
                  ),
                  fit: BoxFit.fitHeight,
                )
              : kIsWeb
                  ? Image.network(
                      pict.resource.network!,
                    )
                  : CachedNetworkImage(
                      imageUrl: pict.resource.network!,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      fit: BoxFit.fitHeight,
                    ),
        ),
      ),
    );
  }
}
