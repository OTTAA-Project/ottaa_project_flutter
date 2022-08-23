import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';

class MiniPicto extends StatelessWidget {
  final Pict pict;
  final VoidCallback onTap;
  final bool localImg;

  const MiniPicto({
    Key? key,
    required this.pict,
    required this.onTap,
    required this.localImg,
  }) : super(key: key);

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
                    'assets/imgs/${pict.imagen.picto}.webp',
                  ),
                  fit: BoxFit.fitHeight,
                )
              : kIsWeb
                  ? Image.network(
                      pict.imagen.pictoEditado == null ? pict.imagen.picto : pict.imagen.pictoEditado!,
                    )
                  : CachedNetworkImage(
                      imageUrl: pict.imagen.pictoEditado == null ? pict.imagen.picto : pict.imagen.pictoEditado!,
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
