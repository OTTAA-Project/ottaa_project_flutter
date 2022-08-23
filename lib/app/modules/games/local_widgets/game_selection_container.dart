import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/page_viewer_widget/local_widgets/page_viewer_container.dart';

import 'game_model_data.dart';

class GameSelectionContainer extends StatelessWidget {
  const GameSelectionContainer({
    Key? key,
    required this.pageControllerGame,
    required this.gameTypes,
    required this.color,
    required this.verticalSize,
    required this.horizontalSize,
  }) : super(key: key);

  final PageController pageControllerGame;
  final Color color;
  final double verticalSize;
  final double horizontalSize;
  final List<GameModelData> gameTypes;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageControllerGame,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(horizontalSize * 0.02),
          child: PageViewerContainer(
            color: color,
            subtitle: gameTypes[index].subtitle,
            title: gameTypes[index].title,
            verticalSize: verticalSize,
            horizontalSize: horizontalSize,
            completedLevel: gameTypes[index].completedNumber,
            totalLevel: gameTypes[index].totalLevel,
            imageAsset: gameTypes[index].imageAsset,
          ),
        );
      },
    );
  }
}
