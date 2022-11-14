import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/center_button_widget.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/game_model_data.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/game_selection_container.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/grupo_selection_container.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class PageViewerWidget extends StatelessWidget {
  PageViewerWidget({
    Key? key,
    required this.verticalSize,
    required this.horizontalSize,
    required this.gameSelectionOrGruposSelection,
    required this.nextButton,
    required this.previousButton,
    required this.pageControllerGame,
    required this.pageControllerGrupo,
    required this.centerButton,
    required this.color,
    required this.onTap,
    this.language,
    this.grupos,
    this.gameTypes,
  }) : super(key: key);
  final double verticalSize;
  final double horizontalSize;
  final bool gameSelectionOrGruposSelection;
  final void Function()? previousButton, nextButton, centerButton, onTap;
  final PageController pageControllerGame, pageControllerGrupo;
  final Color color;
  List<GameModelData>? gameTypes;
  List<Grupos>? grupos;
  String? language;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ///Container for aesthetics
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: verticalSize * 0.18,
              color: kOTTAAOrangeNew,
            ),
          ),

          ///leftOne
          Positioned(
            bottom: 0,
            left: 0,
            child: ColumnWidget(
              onTap: previousButton,
              color: kOTTAAOrangeNew,
              horizontalSize: horizontalSize,
              verticalSize: verticalSize,
              icon: Icons.skip_previous_rounded,
            ),
          ),

          ///rightOne
          Positioned(
            bottom: 0,
            right: 0,
            child: ColumnWidget(
              onTap: nextButton,
              color: kOTTAAOrangeNew,
              horizontalSize: horizontalSize,
              verticalSize: verticalSize,
              icon: Icons.skip_next_rounded,
            ),
          ),

          ///CenterContainer
          Positioned(
            left: horizontalSize * 0.149,
            right: horizontalSize * 0.149,
            bottom: verticalSize * 0.12,
            child: Container(
              height: verticalSize * 0.7,
              width: horizontalSize * 0.3,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(verticalSize * 0.05),
              ),
            ),
          ),

          ///PageViewer for game selection and other with grupo selection
          Positioned(
            left: horizontalSize * 0.168,
            right: horizontalSize * 0.168,
            bottom: verticalSize * 0.25,
            child: Container(
              height: gameSelectionOrGruposSelection
                  ? verticalSize * 0.5
                  : verticalSize * 0.6,
              width: horizontalSize * 0.6,
              child: gameSelectionOrGruposSelection
                  ? GameSelectionContainer(
                      color: color,
                      pageControllerGame: pageControllerGame,
                      horizontalSize: horizontalSize,
                      verticalSize: verticalSize,
                      gameTypes: gameTypes!,
                    )
                  : GrupoSelectionContainer(
                      pageControllerGrupo: pageControllerGrupo,
                      color: kOTTAAOrangeNew,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      grupos: grupos!,
                      language: language,
                    ),
            ),
          ),

          ///centerButton
          Positioned(
            left: 0,
            right: 0,
            bottom: verticalSize * 0.027,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CenterButtonWidget(
                  verticalSize: verticalSize,
                  horizontalSize: horizontalSize,
                  color: kOTTAAOrangeNew,
                  //todo: provide the functionality
                  onTap: centerButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
