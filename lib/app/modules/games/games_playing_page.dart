import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/score_dialouge_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class GamesPlayingPage extends GetView<GamesController> {
  const GamesPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('${controller.gameTypes[controller.gameSelected].title}'),
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
              onTap: () {
                controller.muteOrNot.value = !controller.muteOrNot.value;
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
    );
  }
}
