import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/picto_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class WhatsThePicto extends GetView<GamesController> {
  const WhatsThePicto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Positioned(
          left: horizontalSize * 0.1,
          top: verticalSize * 0.13,
          child: Text(
            'Whats the Picto?',
            style: TextStyle(
              color: Colors.white,
              fontSize: verticalSize * 0.04,
            ),
          ),
        ),
        Positioned(
          left: horizontalSize * 0.4,
          top: verticalSize * 0.06,
          child: Image.asset(
            'assets/icono_ottaa.webp',
            height: verticalSize * 0.2,
          ),
        ),
        //todo: update the photo init and change it back to the
        Positioned(
          left: horizontalSize * 0.55,
          top: verticalSize * 0.06,
          child: Container(
            padding: EdgeInsets.all(verticalSize * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(verticalSize * 0.02),
            ),
            child: Container(
              height: verticalSize * 0.2,
              width: horizontalSize * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(verticalSize * 0.02),
                border: Border.all(
                  color: Colors.lightGreenAccent,
                  width: verticalSize * 0.005,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.help_outline,
                  color: kOTTAAOrangeNew,
                  size: verticalSize * 0.19,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: verticalSize * 0.02,
          left: horizontalSize * 0.02,
          child: Obx(
            () => Row(
              children: [
                PictoWidget(
                  onTap: () async {
                    controller.imageOrEmoji[0].value =
                        !controller.imageOrEmoji[0].value;
                    //todo: create a function for adding to score and do some magic
                    await Future.delayed(
                      Duration(seconds: 2),
                    );
                    controller.imageOrEmoji[0].value =
                        !controller.imageOrEmoji[0].value;
                  },
                  verticalSize: verticalSize,
                  horizontalSize: horizontalSize,
                  imageUrl: '',
                  name: '',
                  imageOrResult: controller.imageOrEmoji[0].value,
                  selectedAnswer: controller.selectedAnswer[0].value,
                ),
                SizedBox(
                  width: horizontalSize * 0.03,
                ),
                PictoWidget(
                  onTap: () async {
                    controller.imageOrEmoji[1].value =
                        !controller.imageOrEmoji[1].value;
                    //todo: create a function for adding to score and do some magic
                    await Future.delayed(
                      Duration(seconds: 2),
                    );
                    controller.imageOrEmoji[1].value =
                        !controller.imageOrEmoji[1].value;
                  },
                  verticalSize: verticalSize,
                  horizontalSize: horizontalSize,
                  imageUrl: '',
                  name: 'vvb',
                  imageOrResult: controller.imageOrEmoji[1].value,
                  selectedAnswer: controller.selectedAnswer[1].value,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
