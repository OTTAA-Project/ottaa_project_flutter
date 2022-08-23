import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/local_widgets/speak_pict_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/search_sentence.dart';
import 'sentences_controller.dart';

class SentencesPage extends GetView<SentencesController> {
  const SentencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;

    final verticalBound = verticalSize * 0.02;
    final horizontalBound = horizontalSize * 0.43;

    final directionButtonWidth = horizontalSize * 0.10;
    final directionButtonHeight = verticalSize * 0.5;

    final iconSize = verticalSize * 0.1;
    return GetBuilder<SentencesController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kOTTAAOrangeNew,
            leading: Container(),
            foregroundColor: Colors.white,
            elevation: 0,
            title: Text('most_used_sentences'.tr),
            /*actions: [
            Icon(
              Icons.reorder,
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                // _pictogramController.categoryGridviewOrPageview.value =
                //     !_pictogramController
                //         .categoryGridviewOrPageview.value;
              },
              child: Icon(
                Icons.view_carousel,
                size: 30,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: Icon(
            //     Icons.add_circle_outline,
            //     size: 30,
            //   ),
            // ),
            // Icon(
            //   Icons.cloud_download,
            //   size: 30,
            // ),
            const SizedBox(
              width: 16,
            ),
          ],*/
          ),
          body: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: kOTTAAOrangeNew,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.cancel,
                                size: iconSize,
                                color: Colors.white,
                              ),
                            ),

                            /// for keeping them in order and the button will be in separate Positioned
                            Container(),
                            GestureDetector(
                              onTap: () => Get.to(const SearchSentence()),
                              child: Icon(
                                Icons.search,
                                size: iconSize,
                                color: Colors.white,
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: verticalSize * 0.17,
                  child: Container(
                    height: verticalSize * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.099),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                      child: Center(
                        child: GetBuilder<SentencesController>(
                          id: "sentence",
                          builder: (sentencesController) => FadeInDown(
                            controller: (controller) => sentencesController.sentenceAnimationController = controller,
                            from: 30,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (sentencesController.sentencesPicts.isNotEmpty)
                                    SizedBox(
                                      height: verticalSize / 3,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sentencesController.sentencesPicts[sentencesController.sentencesIndex].length + 1,
                                        itemBuilder: (BuildContext context, int index) => SpeakPicWidget(
                                          pict: sentencesController.sentencesPicts[sentencesController.sentencesIndex].length > index ? sentencesController.sentencesPicts[sentencesController.sentencesIndex][index] : null,
                                          speak: sentencesController.speak,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (controller.showCircular.value)
                  const Center(
                    child: CircularProgressIndicator(
                      color: kOTTAAOrangeNew,
                    ),
                  ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kOTTAAOrangeNew,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                      ),
                    ),
                    width: directionButtonWidth,
                    height: directionButtonHeight,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.sentencesIndex--;
                        },
                        child: Icon(
                          Icons.skip_previous,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kOTTAAOrangeNew,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                      ),
                    ),
                    width: directionButtonWidth,
                    height: directionButtonHeight,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.sentencesIndex++;
                        },
                        child: Icon(
                          Icons.skip_next,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: verticalBound,
                  left: horizontalBound,
                  right: horizontalBound,
                  child: GestureDetector(
                    onTap: () async {
                      await controller.speak();
                    },
                    child: const OttaLogoWidget(),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
        );
      },
    );
  }
}
/*
class Widhdhd extends StatelessWidget {
  const Widhdhd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: verticalSize * 0.2,
          width: horizontalSize,
          color: kOTTAOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    _.sentencesIndex--;
                  },
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: horizontalSize / 10,
                  )),
                ),
              ),
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    _.speak();
                  },
                  child: Center(
                      child: Icon(
                    Icons.surround_sound_rounded,
                    color: Colors.white,
                    size: horizontalSize / 10,
                  )),
                ),
              ),
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    Get.offNamed(AppRoutes.HOME);
                  },
                  child: Center(
                      child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: horizontalSize / 10,
                  )),
                ),
              ),
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    _.sentencesIndex++;
                  },
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: horizontalSize / 10,
                  )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}*/
