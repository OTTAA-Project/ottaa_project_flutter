import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/score_dialouge_widget.dart';
import 'package:ottaa_project_flutter/app/modules/games/mamory_game.dart';
import 'package:ottaa_project_flutter/app/modules/games/match_picto.dart';
import 'package:ottaa_project_flutter/app/modules/games/whats_the_picto.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class GamesPlayingPage extends GetView<GamesController> {
  const GamesPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        controller.cancelTimer();
        await controller.pauseMusic();
        controller.currentStreak.value = 0;
        controller.correctScore.value = 0;
        controller.incorrectScore.value = 0;
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: kOTTAAOrangeNew,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () async {
              controller.cancelTimer();
              await controller.pauseMusic();
              controller.currentStreak.value = 0;
              controller.correctScore.value = 0;
              controller.incorrectScore.value = 0;
              Get.back();
            },
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.white,
            ),
          ),
          title: GestureDetector(
            onTap: (){
              print(controller.bottomWidgetNames[1].value);
              print(controller.randomPositionsForBottomWidgets[1].value);
            },
            child: Text(
                '${controller.gameTypes[controller.gameSelected.value].title}'),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ScoreDialougeWidget(
                        verticalSize: verticalSize,
                        horizontalSize: horizontalSize,
                        correct: controller.correctScore.value,
                        incorrect: controller.incorrectScore.value,
                        maximumStreak: controller.maximumStreak.value,
                        timeInSeconds: controller.timeInSeconds.value,
                        color: kOTTAAOrangeNew,
                      );
                    });
              },
              child: Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.white,
                size: verticalSize * 0.04,
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  controller.helpOrNot.value = !controller.helpOrNot.value;
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.025),
                  child: Icon(
                    controller.helpOrNot.value
                        ? Icons.speaker_notes_off_outlined
                        : Icons.help_center_rounded,
                    color: Colors.white,
                    size: verticalSize * 0.04,
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  controller.muteOrNot.value = !controller.muteOrNot.value;
                  if (controller.muteOrNot.value) {
                    await controller.backgroundMusicPlayer.pause();
                    // controller.difficultyLevel.value = 1;
                    // controller.changeViewForListview.value = !controller.changeViewForListview.value;
                    // await Future.delayed(Duration(seconds: 1));
                    // controller.changeViewForListview.value = !controller.changeViewForListview.value;
                  } else {
                    await controller.backgroundMusicPlayer.play();
                    controller.difficultyLevel.value = 0;
                    // controller.changeViewForListview.value = !controller.changeViewForListview.value;
                    // await Future.delayed(Duration(seconds: 1));
                    // controller.changeViewForListview.value = !controller.changeViewForListview.value;
                  }
                },
                child: Icon(
                  controller.muteOrNot.value
                      ? Icons.volume_mute
                      : Icons.volume_up,
                  color: Colors.white,
                  size: verticalSize * 0.04,
                ),
              ),
            ),
            SizedBox(
              width: horizontalSize * 0.025,
            ),
          ],
        ),
        body: Obx(
          () => controller.gameSelected.value == 0
              ? WhatsThePicto()
              : controller.gameSelected.value == 1
                  ? MatchPicto()
                  : MemoryGame(),
        ),
      ),
    );
  }
}
