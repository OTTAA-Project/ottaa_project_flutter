import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class SentenceWidget extends StatelessWidget {
  const SentenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
      id: "sentence",
      builder: (_) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // SENTENCE ROW
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: verticalSize * 0.04),
              child: Container(
                height: verticalSize * 0.2,
                child: _.sentencePicts.length >= 1
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _.sentencePicts.length + 8,
                        itemBuilder: (BuildContext context, int index) {
                          final Pict speakPict = Pict(
                            localImg: true,
                            id: 0,
                            texto: Texto(),
                            tipo: 6,
                            imagen: Imagen(picto: "logo_ottaa_dev"),
                          );
                          if (_.sentencePicts.length > index) {
                            final Pict pict = _.sentencePicts[index];
                            return FadeInDown(
                              from: 30,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalSize * 0.01),
                                // margin: EdgeInsets.all(10),
                                child: MiniPicto(
                                  localImg: pict.localImg,
                                  pict: pict,
                                  onTap: () {
                                    _.speak();
                                  },
                                ),
                              ),
                            );
                          } else if (_.sentencePicts.length == index) {
                            return Bounce(
                              from: 6,
                              infinite: true,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalSize * 0.01),
                                // margin: EdgeInsets.all(10),
                                child: MiniPicto(
                                  localImg: speakPict.localImg,
                                  pict: speakPict,
                                  onTap: () {
                                    _.speak();
                                  },
                                ),
                              ),
                            );
                          }
                          return FadeInDown(
                            from: 30,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalSize * 0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kWhite,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: DottedBorder(
                                  dashPattern: [8, 8],
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      width: horizontalSize * 0.1,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalSize * 0.01),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => FadeInDown(
                          from: 30,
                          child: emptyWidget(horizontalSize: horizontalSize),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyWidget({required double horizontalSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
        ),
        padding: const EdgeInsets.all(10),
        child: DottedBorder(
          dashPattern: [8, 8],
          child: Container(
            width: horizontalSize * 0.1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
