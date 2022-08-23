import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/picto_match_picto_bottom_widget.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/picto_match_picto_top_widget.dart';

class MatchPicto extends GetView<GamesController> {
  const MatchPicto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Obx(
      () => Stack(
        children: [
          ///4 bottom ones
          Positioned(
            left: horizontalSize * 0.05,
            bottom: verticalSize * 0.05,
            child: Container(
              height: verticalSize * 0.4,
              width: horizontalSize * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(verticalSize * 0.02),
              ),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.28,
            bottom: verticalSize * 0.05,
            child: Container(
              height: verticalSize * 0.4,
              width: horizontalSize * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(verticalSize * 0.02),
              ),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.51,
            bottom: verticalSize * 0.05,
            child: controller.difficultyLevel.value >= 1
                ? Container(
                    height: verticalSize * 0.4,
                    width: horizontalSize * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(verticalSize * 0.02),
                    ),
                  )
                : Container(),
          ),
          Positioned(
            left: horizontalSize * 0.74,
            bottom: verticalSize * 0.05,
            child: controller.difficultyLevel.value >= 2
                ? Container(
                    height: verticalSize * 0.4,
                    width: horizontalSize * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(verticalSize * 0.02),
                    ),
                  )
                : Container(),
          ),
          PictoMatchPictoBottomWidget(
            horizontalSize: horizontalSize,
            verticalSize: verticalSize,
            left: horizontalSize * 0.05,
            top: verticalSize * 0.46,
            foundOrNot: controller.topOrBottom[controller.randomPositionsForBottomWidgets[0].value].value,
            onTap: () async {
              controller.bottomWidgetFunction(
                index: controller.randomPositionsForBottomWidgets[0].value,
                text: controller.bottomWidgetNames[0].value,
                context: context,
              );
            },
            name: controller.bottomWidgetNames[0].value,
          ),
          PictoMatchPictoBottomWidget(
            horizontalSize: horizontalSize,
            verticalSize: verticalSize,
            left: horizontalSize * 0.28,
            top: verticalSize * 0.46,
            foundOrNot: controller.topOrBottom[controller.randomPositionsForBottomWidgets[1].value].value,
            onTap: () async => controller.bottomWidgetFunction(
              index: controller.randomPositionsForBottomWidgets[1].value,
              text: controller.bottomWidgetNames[1].value,
              context: context,
            ),
            name: controller.bottomWidgetNames[1].value,
          ),
          controller.difficultyLevel.value >= 1
              ? PictoMatchPictoBottomWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: horizontalSize * 0.51,
                  top: verticalSize * 0.46,
                  foundOrNot: controller.topOrBottom[controller.randomPositionsForBottomWidgets[2].value].value,
                  onTap: () async => controller.bottomWidgetFunction(
                    index: controller.randomPositionsForBottomWidgets[2].value,
                    text: controller.bottomWidgetNames[2].value,
                    context: context,
                  ),
                  name: controller.bottomWidgetNames[2].value,
                )
              : Container(),

          controller.difficultyLevel.value >= 2
              ? PictoMatchPictoBottomWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: horizontalSize * 0.74,
                  top: verticalSize * 0.46,
                  foundOrNot: controller.topOrBottom[controller.randomPositionsForBottomWidgets[3].value].value,
                  onTap: () async {
                    controller.bottomWidgetFunction(
                      index: controller.randomPositionsForBottomWidgets[3].value,
                      text: controller.bottomWidgetNames[3].value,
                      context: context,
                    );
                    // print(controller.questions[controller.randomPositionsForBottomWidgets[3].value].text);
                  },
                  name: controller.bottomWidgetNames[3].value,
                )
              : Container(),

          /// 4 tops one
          Positioned(
            left: horizontalSize * 0.05,
            top: verticalSize * 0.02,
            child: Obx(
              () => Container(
                height: verticalSize * 0.4,
                width: horizontalSize * 0.2,
                decoration: BoxDecoration(
                  color: controller.topOrBottom[0].value ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(verticalSize * 0.02),
                ),
              ),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.28,
            top: verticalSize * 0.02,
            child: Obx(
              () => Container(
                height: verticalSize * 0.4,
                width: horizontalSize * 0.2,
                decoration: BoxDecoration(
                  color: controller.topOrBottom[1].value ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(verticalSize * 0.02),
                ),
              ),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.51,
            top: verticalSize * 0.02,
            child: Obx(
              () => controller.difficultyLevel.value >= 1
                  ? Container(
                      height: verticalSize * 0.4,
                      width: horizontalSize * 0.2,
                      decoration: BoxDecoration(
                        color: controller.topOrBottom[2].value ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(verticalSize * 0.02),
                      ),
                    )
                  : Container(),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.74,
            top: verticalSize * 0.02,
            child: Obx(
              () => controller.difficultyLevel.value >= 2
                  ? Container(
                      height: verticalSize * 0.4,
                      width: horizontalSize * 0.2,
                      decoration: BoxDecoration(
                        color: controller.topOrBottom[3].value ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(verticalSize * 0.02),
                      ),
                    )
                  : Container(),
            ),
          ),
          PictoMatchPictoWidget(
            horizontalSize: horizontalSize,
            verticalSize: verticalSize,
            left: controller.topOrBottom[0].value ? horizontalSize * 0.05 : horizontalSize * controller.leftRatios[controller.randomPositionsForBottomWidgets[0].value]!,
            top: controller.topOrBottom[0].value ? verticalSize * 0.02 : verticalSize * 0.46,
            topOrBottom: controller.topOrBottom[0].value,
            onTap: () async => controller.topWidgetFunction(
              text: controller.questions[0].text,
              index: 0,
              context: context,
            ),
            name: controller.questions[0].text,
            imageUrl: controller.questions[0].imageUrl,
          ),
          PictoMatchPictoWidget(
            horizontalSize: horizontalSize,
            verticalSize: verticalSize,
            left: controller.topOrBottom[1].value ? horizontalSize * 0.28 : horizontalSize * controller.leftRatios[controller.randomPositionsForBottomWidgets[1].value]!,
            top: controller.topOrBottom[1].value ? verticalSize * 0.02 : verticalSize * 0.46,
            // bottom: controller.topOrBottom[1].value ? 0 : verticalSize * 0.02,
            topOrBottom: controller.topOrBottom[1].value,
            onTap: () async => controller.topWidgetFunction(
              text: controller.questions[1].text,
              index: 1,
              context: context,
            ),
            name: controller.questions[1].text,
            imageUrl: controller.questions[1].imageUrl,
          ),
          controller.difficultyLevel.value >= 1
              ? PictoMatchPictoWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: controller.topOrBottom[2].value ? horizontalSize * 0.51 : horizontalSize * controller.leftRatios[controller.randomPositionsForBottomWidgets[2].value]!,
                  top: controller.topOrBottom[2].value ? verticalSize * 0.02 : verticalSize * 0.46,
                  // bottom: controller.topOrBottom[2].value ? 0 : verticalSize * 0.02,
                  topOrBottom: controller.topOrBottom[2].value,
                  onTap: () async => controller.topWidgetFunction(
                    index: 2,
                    text: controller.questions[2].text,
                    context: context,
                  ),
                  name: controller.questions[2].text,
                  imageUrl: controller.questions[2].imageUrl,
                )
              : Container(),
          controller.difficultyLevel.value >= 2
              ? PictoMatchPictoWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: controller.topOrBottom[3].value ? horizontalSize * 0.74 : horizontalSize * controller.leftRatios[controller.randomPositionsForBottomWidgets[3].value]!,
                  top: controller.topOrBottom[3].value ? verticalSize * 0.02 : verticalSize * 0.46,
                  // bottom: controller.topOrBottom[3].value ? 0 : verticalSize * 0.02,
                  topOrBottom: controller.topOrBottom[3].value,
                  onTap: () async => controller.topWidgetFunction(
                    index: 3,
                    context: context,
                    text: controller.questions[3].text,
                  ),
                  name: controller.questions[3].text,
                  imageUrl: controller.questions[3].imageUrl,
                )
              : Container(),
        ],
      ),
    );
  }
}
