import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/picto_memory_game_widget.dart';

class MemoryGame extends GetView<GamesController> {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return GetBuilder<GamesController>(
      id: 'MemoryGame',
      builder: (controller) {
        return Obx(
          () => Stack(
            children: [
              /// top widgets
              Positioned(
                left: horizontalSize * 0.05,
                top: verticalSize * 0.03,
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
                top: verticalSize * 0.03,
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
                top: verticalSize * 0.03,
                child: controller.difficultyLevel.value >= 1
                    ? Container(
                        height: verticalSize * 0.4,
                        width: horizontalSize * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(verticalSize * 0.02),
                        ),
                      )
                    : Container(),
              ),
              Positioned(
                left: horizontalSize * 0.74,
                top: verticalSize * 0.03,
                child: controller.difficultyLevel.value >= 2
                    ? Container(
                        height: verticalSize * 0.4,
                        width: horizontalSize * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(verticalSize * 0.02),
                        ),
                      )
                    : Container(),
              ),
              PictoMemoryGameWidget(
                onTap: () async => controller.memoryGameOnTap(
                  context: context,
                  index: 0,
                  text:
                      controller.questions[controller.positions[0].value].text,
                ),
                name: controller.questions[controller.positions[0].value].text,
                verticalSize: verticalSize,
                horizontalSize: horizontalSize,
                imageUrl: controller
                    .questions[controller.positions[0].value].imageUrl,
                showOrHide: controller.showOrHideMemoryGame[0].value,
                bottom: null,
                left: horizontalSize * 0.05,
                top: verticalSize * 0.03,
              ),
              PictoMemoryGameWidget(
                onTap: () async => controller.memoryGameOnTap(
                  context: context,
                  index: 1,
                  text:
                      controller.questions[controller.positions[1].value].text,
                ),
                name: controller.questions[controller.positions[1].value].text,
                verticalSize: verticalSize,
                horizontalSize: horizontalSize,
                imageUrl: controller
                    .questions[controller.positions[1].value].imageUrl,
                showOrHide: controller.showOrHideMemoryGame[1].value,
                bottom: null,
                left: horizontalSize * 0.28,
                top: verticalSize * 0.03,
              ),
              controller.difficultyLevel.value >= 1
                  ? PictoMemoryGameWidget(
                      onTap: () async => controller.memoryGameOnTap(
                        context: context,
                        index: 2,
                        text: controller
                            .questions[controller.positions[2].value].text,
                      ),
                      name: controller
                          .questions[controller.positions[2].value].text,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      imageUrl: controller
                          .questions[controller.positions[2].value].imageUrl,
                      showOrHide: controller.showOrHideMemoryGame[2].value,
                      bottom: null,
                      left: horizontalSize * 0.51,
                      top: verticalSize * 0.03,
                    )
                  : Container(),
              controller.difficultyLevel.value >= 2
                  ? PictoMemoryGameWidget(
                      onTap: () async => controller.memoryGameOnTap(
                        context: context,
                        index: 3,
                        text: controller
                            .questions[controller.positions[3].value].text,
                      ),
                      name: controller
                          .questions[controller.positions[3].value].text,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      imageUrl: controller
                          .questions[controller.positions[3].value].imageUrl,
                      showOrHide: controller.showOrHideMemoryGame[3].value,
                      bottom: null,
                      left: horizontalSize * 0.74,
                      top: verticalSize * 0.03,
                    )
                  : Container(),

              /// bottom widgets
              Positioned(
                left: horizontalSize * 0.05,
                bottom: verticalSize * 0.03,
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
                bottom: verticalSize * 0.03,
                child: Container(
                  height: verticalSize * 0.4,
                  width: horizontalSize * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(verticalSize * 0.02),
                  ),
                ),
              ),
              controller.difficultyLevel.value >= 1
                  ? Positioned(
                      left: horizontalSize * 0.51,
                      bottom: verticalSize * 0.03,
                      child: Container(
                        height: verticalSize * 0.4,
                        width: horizontalSize * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(verticalSize * 0.02),
                        ),
                      ),
                    )
                  : Container(),
              controller.difficultyLevel.value >= 2
                  ? Positioned(
                      left: horizontalSize * 0.74,
                      bottom: verticalSize * 0.03,
                      child: Container(
                        height: verticalSize * 0.4,
                        width: horizontalSize * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(verticalSize * 0.02),
                        ),
                      ),
                    )
                  : Container(),
              PictoMemoryGameWidget(
                onTap: () async => controller.memoryGameOnTap(
                  index: 4,
                  context: context,
                  text:
                      controller.questions[controller.positions[4].value].text,
                ),
                name: controller.questions[controller.positions[4].value].text,
                verticalSize: verticalSize,
                horizontalSize: horizontalSize,
                imageUrl: controller
                    .questions[controller.positions[4].value].imageUrl,
                showOrHide: controller.showOrHideMemoryGame[4].value,
                left: horizontalSize * 0.05,
                bottom: verticalSize * 0.03,
                top: null,
              ),
              PictoMemoryGameWidget(
                onTap: () async => controller.memoryGameOnTap(
                  context: context,
                  index: 5,
                  text:
                      controller.questions[controller.positions[5].value].text,
                ),
                name: controller.questions[controller.positions[5].value].text,
                verticalSize: verticalSize,
                horizontalSize: horizontalSize,
                imageUrl: controller
                    .questions[controller.positions[5].value].imageUrl,
                showOrHide: controller.showOrHideMemoryGame[5].value,
                left: horizontalSize * 0.28,
                bottom: verticalSize * 0.03,
                top: null,
              ),
              controller.difficultyLevel.value >= 1
                  ? PictoMemoryGameWidget(
                      onTap: () async => controller.memoryGameOnTap(
                        index: 6,
                        context: context,
                        text: controller
                            .questions[controller.positions[6].value].text,
                      ),
                      name: controller
                          .questions[controller.positions[6].value].text,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      imageUrl: controller
                          .questions[controller.positions[6].value].imageUrl,
                      showOrHide: controller.showOrHideMemoryGame[6].value,
                      bottom: verticalSize * 0.03,
                      top: null,
                      left: horizontalSize * 0.51,
                    )
                  : Container(),
              controller.difficultyLevel.value >= 2
                  ? PictoMemoryGameWidget(
                      onTap: () async => controller.memoryGameOnTap(
                        context: context,
                        index: 7,
                        text: controller
                            .questions[controller.positions[7].value].text,
                      ),
                      name: controller
                          .questions[controller.positions[7].value].text,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      imageUrl: controller
                          .questions[controller.positions[7].value].imageUrl,
                      showOrHide: controller.showOrHideMemoryGame[7].value,
                      bottom: verticalSize * 0.03,
                      top: null,
                      left: horizontalSize * 0.74,
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
