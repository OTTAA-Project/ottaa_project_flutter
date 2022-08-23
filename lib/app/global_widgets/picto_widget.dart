import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/theme/group_colors.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class Picto extends StatelessWidget {
  final Pict pict;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double height;
  final double width;
  final String languaje;
  final bool localImg;

  const Picto({
    Key? key,
    required this.pict,
    required this.onTap,
    required this.height,
    required this.width,
    required this.languaje,
    required this.localImg,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String texto;

    switch (languaje) {
      case "es":
        texto = pict.texto.es;
        break;
      case "en":
        texto = pict.texto.en;
        break;

      default:
        texto = pict.texto.es;
    }

    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                //height: 320,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: kGroupColor[pict.tipo], borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: localImg
                        ? Image.asset('assets/imgs/${pict.imagen.picto}.webp')
                        : kIsWeb
                            ? Image.network(
                                pict.imagen.pictoEditado == null ? pict.imagen.picto : pict.imagen.pictoEditado!,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kOTTAAOrangeNew,
                                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                    ),
                                  );
                                },
                              )
                            : CachedNetworkImage(
                                imageUrl: pict.imagen.pictoEditado == null ? pict.imagen.picto : pict.imagen.pictoEditado!,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    texto.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
