import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:picto_widget/picto_widget.dart';

class PictogramWidget extends StatelessWidget {
  final Pict pictogam;
  final VoidCallback onTap;
  final String language;

  const PictogramWidget({super.key, required this.pictogam, required this.onTap, this.language = 'es'});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return PictoWidget(
      text: pictogam.texto.toJson()[language],
      imageUrl: pictogam.imagen.pictoEditado ?? pictogam.imagen.picto,
      onTap: onTap,
      height: height * 0.38,
      width: width * 0.175,
      colorNumber: pictogam.tipo,
    );
  }
}
