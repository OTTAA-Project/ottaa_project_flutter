import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/grupo_widget.dart';

class GrupoSelectionContainer extends StatelessWidget {
  GrupoSelectionContainer({
    Key? key,
    required this.pageControllerGrupo,
    required this.verticalSize,
    required this.horizontalSize,
    required this.color,
    this.language,
    required this.grupos,
  }) : super(key: key);
  final PageController pageControllerGrupo;
  final Color color;
  final double verticalSize;
  final double horizontalSize;
  final List<Grupos> grupos;
  String? language;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageControllerGrupo,
      itemCount: grupos.length,
      itemBuilder: (context, index) {
        return GrupoWidget(
          horizontalSize: horizontalSize,
          verticalSize: verticalSize,
          color: color,
          title: 'en' == language
              ? grupos[index].texto.en.toUpperCase()
              : grupos[index].texto.es.toUpperCase(),
          imageUrl: grupos[index].imagen.pictoEditado != null
              ? grupos[index].imagen.pictoEditado!
              : grupos[index].imagen.picto,
        );
      },
    );
  }
}
