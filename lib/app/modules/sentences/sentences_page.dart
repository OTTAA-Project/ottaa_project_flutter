import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'local_widgets/search_sentence.dart';
import 'sentences_controller.dart';

class SentencesPage extends GetView<SentencesController> {
  SentencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<SentencesController>(
      builder: (_) => Scaffold(
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
              Container(
                child: Column(
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
                                size: verticalSize * 0.1,
                                color: Colors.white,
                              ),
                            ),

                            /// for keeping them in order and the button will be in separate Positioned
                            Container(),
                            GestureDetector(
                              onTap: () => Get.to(SearchSentence()),
                              child: Icon(
                                Icons.search,
                                size: verticalSize * 0.1,
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
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: verticalSize * 0.17,
                child: Container(
                  height: verticalSize * 0.8,
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.099),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                    child: Center(
                      child: GetBuilder<SentencesController>(
                        id: "sentence",
                        builder: (_) => FadeInDown(
                          controller: (controller) =>
                              _.sentenceAnimationController = controller,
                          from: 30,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _.sentencesPicts.isNotEmpty
                                    ? Container(
                                        height: verticalSize / 3,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              _.sentencesPicts[_.sentencesIndex]
                                                      .length +
                                                  1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final Pict speakPict = Pict(
                                              localImg: true,
                                              id: 0,
                                              texto: Texto(en: "", es: ""),
                                              tipo: 6,
                                              imagen: Imagen(
                                                  picto: "logo_ottaa_dev"),
                                            );
                                            if (_
                                                    .sentencesPicts[
                                                        _.sentencesIndex]
                                                    .length >
                                                index) {
                                              final Pict pict =
                                                  _.sentencesPicts[
                                                      _.sentencesIndex][index];
                                              return Container(
                                                margin: EdgeInsets.all(10),
                                                child: MiniPicto(
                                                  localImg: pict.localImg,
                                                  pict: pict,
                                                  onTap: () {
                                                    _.speak();
                                                  },
                                                ),
                                              );
                                            } else {
                                              return Bounce(
                                                from: 6,
                                                infinite: true,
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: MiniPicto(
                                                    localImg:
                                                        speakPict.localImg,
                                                    pict: speakPict,
                                                    onTap: () {
                                                      _.speak();
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              controller.showCircular.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kOTTAAOrangeNew,
                      ),
                    )
                  : Container(),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: kOTTAAOrangeNew,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                    ),
                  ),
                  width: horizontalSize * 0.10,
                  height: verticalSize * 0.5,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.sentencesIndex--;
                      },
                      child: Icon(
                        Icons.skip_previous,
                        size: verticalSize * 0.1,
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
                  decoration: BoxDecoration(
                    color: kOTTAAOrangeNew,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  width: horizontalSize * 0.10,
                  height: verticalSize * 0.5,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.sentencesIndex++;
                      },
                      child: Icon(
                        Icons.skip_next,
                        size: verticalSize * 0.1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: verticalSize * 0.02,
                left: horizontalSize * 0.43,
                right: horizontalSize * 0.43,
                child: GestureDetector(
                  onTap: () async {
                    await controller.speak();
                  },
                  child: OttaLogoWidget(),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
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
