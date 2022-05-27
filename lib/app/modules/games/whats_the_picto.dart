import 'package:cached_network_image/cached_network_image.dart';
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
          child: GestureDetector(
            onTap: () {
              controller.speakName();
            },
            child: Image.asset(
              'assets/icono_ottaa.webp',
              height: verticalSize * 0.2,
            ),
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
                child: Stack(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: kOTTAAOrangeNew,
                      size: verticalSize * 0.19,
                    ),
                    Obx(
                      () => AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: controller.showImage.value ? 1 : 0,
                        child: CachedNetworkImage(
                          imageUrl: controller.selectedImage.value,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: verticalSize * 0.02,
          left: horizontalSize * 0.02,
          child: Container(
            height: 400,
            width: horizontalSize * 0.98,
            child: Obx(
              () => controller.changeViewForListview.value
                  ? ListView.builder(
                      itemCount: controller.difficultyLevel.value + 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(right: horizontalSize * 0.03),
                          child: Obx(
                            () => PictoWidget(
                              onTap: () async => await controller
                                  .pictoFunctionWhatsThePicto(index: index),
                              verticalSize: verticalSize,
                              horizontalSize: horizontalSize,
                              imageUrl: controller.questions[index].imageUrl,
                              name: controller.questions[index].text,
                              imageOrResult:
                                  controller.imageOrEmoji[index].value,
                              selectedAnswer: controller.selectedAnswer.value,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
          ),
        ),
      ],
    );
  }
}
