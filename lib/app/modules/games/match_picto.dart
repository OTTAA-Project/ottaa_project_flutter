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
          /// 4 tops one
          Positioned(
            left: horizontalSize * 0.05,
            top: verticalSize * 0.02,
            child: Obx(
              () => Container(
                height: verticalSize * 0.28,
                width: horizontalSize * 0.2,
                decoration: BoxDecoration(
                  color: controller.topOrBottom[0].value
                      ? Colors.white
                      : Colors.black,
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
                height: verticalSize * 0.28,
                width: horizontalSize * 0.2,
                decoration: BoxDecoration(
                  color: controller.topOrBottom[1].value
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(verticalSize * 0.02),
                ),
              ),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.51,
            top: verticalSize * 0.02,
            child: Obx(
              () => controller.difficultyLevel.value == 1
                  ? Container(
                      height: verticalSize * 0.28,
                      width: horizontalSize * 0.2,
                      decoration: BoxDecoration(
                        color: controller.topOrBottom[2].value
                            ? Colors.white
                            : Colors.black,
                        borderRadius:
                            BorderRadius.circular(verticalSize * 0.02),
                      ),
                    )
                  : Container(),
            ),
          ),
          Positioned(
            left: horizontalSize * 0.74,
            top: verticalSize * 0.02,
            child: Obx(
              () => controller.difficultyLevel.value == 2
                  ? Container(
                      height: verticalSize * 0.28,
                      width: horizontalSize * 0.2,
                      decoration: BoxDecoration(
                        color: controller.topOrBottom[3].value
                            ? Colors.white
                            : Colors.black,
                        borderRadius:
                            BorderRadius.circular(verticalSize * 0.02),
                      ),
                    )
                  : Container(),
            ),
          ),
          Obx(
            () => PictoMatchPictoWidget(
              horizontalSize: horizontalSize,
              verticalSize: verticalSize,
              left: controller.topOrBottom[0].value
                  ? horizontalSize * 0.05
                  : horizontalSize * 0.74,
              top: controller.topOrBottom[0].value
                  ? verticalSize * 0.02
                  : verticalSize * 0.47,
              // bottom:
              //     controller.topOrBottom[0].value ? null : verticalSize * 0.02,
              // bottom: null,
              topOrBottom: controller.topOrBottom[0].value,
              onTap: controller.topWidgetFunction,
              name: controller.questions[0].text,
              imageUrl: controller.questions[0].imageUrl,
            ),
          ),
          PictoMatchPictoWidget(
            horizontalSize: horizontalSize,
            verticalSize: verticalSize,
            left: horizontalSize * 0.28,
            top: verticalSize * 0.02,
            // bottom: controller.topOrBottom[1].value ? 0 : verticalSize * 0.02,
            topOrBottom: controller.topOrBottom[1].value,
            onTap: controller.bottomWidgetFunction,
            name: controller.questions[1].text,
            imageUrl: controller.questions[1].imageUrl,
          ),
          controller.difficultyLevel.value == 1
              ? PictoMatchPictoWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: horizontalSize * 0.51,
                  top: verticalSize * 0.02,
                  // bottom: controller.topOrBottom[2].value ? 0 : verticalSize * 0.02,
                  topOrBottom: controller.topOrBottom[2].value,
                  onTap: controller.bottomWidgetFunction,
                  name: controller.questions[2].text,
                  imageUrl: controller.questions[2].imageUrl,
                )
              : Container(),
          controller.difficultyLevel.value == 2
              ? PictoMatchPictoWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: horizontalSize * 0.74,
                  top: verticalSize * 0.02,
                  // bottom: controller.topOrBottom[3].value ? 0 : verticalSize * 0.02,
                  topOrBottom: controller.topOrBottom[3].value,
                  onTap: controller.bottomWidgetFunction,
                  name: controller.questions[3].text,
                  imageUrl: controller.questions[3].imageUrl,
                )
              : Container(),

          ///4 bottom ones
          Positioned(
            left: horizontalSize * 0.05,
            bottom: verticalSize * 0.05,
            child: Container(
              height: verticalSize * 0.28,
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
              height: verticalSize * 0.28,
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
            child: controller.difficultyLevel.value == 1
                ? Container(
                    height: verticalSize * 0.28,
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
            child: controller.difficultyLevel.value == 2
                ? Container(
                    height: verticalSize * 0.28,
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
            bottom: verticalSize * 0.05,
            foundOrNot: controller.topOrBottom[0].value,
            onTap: controller.bottomWidgetFunction,
          ),
          PictoMatchPictoBottomWidget(
            horizontalSize: horizontalSize,
            verticalSize: verticalSize,
            left: horizontalSize * 0.28,
            bottom: verticalSize * 0.05,
            foundOrNot: controller.topOrBottom[1].value,
            onTap: controller.bottomWidgetFunction,
          ),
          controller.difficultyLevel.value == 1
              ? PictoMatchPictoBottomWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: horizontalSize * 0.51,
                  bottom: verticalSize * 0.05,
                  foundOrNot: controller.topOrBottom[2].value,
                  onTap: controller.bottomWidgetFunction,
                )
              : Container(),

          controller.difficultyLevel.value == 2
              ? PictoMatchPictoBottomWidget(
                  horizontalSize: horizontalSize,
                  verticalSize: verticalSize,
                  left: horizontalSize * 0.74,
                  bottom: verticalSize * 0.05,
                  foundOrNot: controller.topOrBottom[3].value,
                  onTap: controller.bottomWidgetFunction,
                )
              : Container(),
        ],
      ),
    );
  }
}
