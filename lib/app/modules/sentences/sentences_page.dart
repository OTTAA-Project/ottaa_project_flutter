import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import 'sentences_controller.dart';

class SentencesPage extends StatelessWidget {
  SentencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<SentencesController>(
        builder: (_) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  GetBuilder<SentencesController>(
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
                                      itemCount: _
                                              .sentencesPicts[_.sentencesIndex]
                                              .length +
                                          1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final Pict speakPict = Pict(
                                          id: 0,
                                          texto: Texto(en: "", es: ""),
                                          tipo: 6,
                                          imagen:
                                              Imagen(picto: "logo_ottaa_dev"),
                                        );
                                        if (_.sentencesPicts[_.sentencesIndex]
                                                .length >
                                            index) {
                                          final Pict pict =
                                              _.sentencesPicts[_.sentencesIndex]
                                                  [index];
                                          return Container(
                                            margin: EdgeInsets.all(10),
                                            child: MiniPicto(
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
              ),
              backgroundColor: Colors.black87,
            ));
  }
}
