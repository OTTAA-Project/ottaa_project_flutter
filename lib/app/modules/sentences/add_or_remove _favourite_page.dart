import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class AddOrRemoveFavouritePage extends StatelessWidget {
  AddOrRemoveFavouritePage({Key? key}) : super(key: key);
  final controller = Get.find<SentencesController>();

  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(controller.ttsController.languaje == 'es-AR'
            ? 'Oraciones favoritas'
            : 'Favourite Sentences'),
        actions: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.favorite,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: GetBuilder<SentencesController>(
        builder: (_) => Container(
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
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: kOTTAAOrangeNew,
                                      ),
                                    );
                                  },
                                );
                                await _.saveFavourite();
                                Get.back();
                                Get.back();
                              },
                              child: Icon(
                                Icons.save,
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
                bottom: verticalSize * 0.3,
                child: Container(
                  height: verticalSize * 0.5,
                  width: horizontalSize * 0.8,
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _.favouriteOrNotPicts.isNotEmpty
                            ? Container(
                                height: verticalSize / 2.5,
                                width: horizontalSize * 0.78,
                                color: _.sentences[_.selectedIndexFavSelection]
                                        .favouriteOrNot
                                    ? Colors.blue
                                    : Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalSize * 0.05),
                                child: Center(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _
                                            .favouriteOrNotPicts[
                                                _.selectedIndexFavSelection]
                                            .length +
                                        1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final Pict speakPict = Pict(
                                        localImg: true,
                                        id: 0,
                                        texto: Texto(),
                                        tipo: 6,
                                        imagen: Imagen(picto: "logo_ottaa_dev"),
                                      );
                                      if (_
                                              .favouriteOrNotPicts[
                                                  _.selectedIndexFavSelection]
                                              .length >
                                          index) {
                                        final Pict pict = _.favouriteOrNotPicts[
                                            _.selectedIndexFavSelection][index];
                                        return Container(
                                          margin: EdgeInsets.all(10),
                                          child: MiniPicto(
                                            localImg: pict.localImg,
                                            pict: pict,
                                            onTap: () {
                                              _
                                                      .sentences[_
                                                          .selectedIndexFavSelection]
                                                      .favouriteOrNot =
                                                  !_
                                                      .sentences[_
                                                          .selectedIndexFavSelection]
                                                      .favouriteOrNot;
                                              _.speakFavOrNot();
                                            },
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          margin: EdgeInsets.all(10),
                                          child: MiniPicto(
                                            localImg: speakPict.localImg,
                                            pict: speakPict,
                                            onTap: () {
                                              _
                                                      .sentences[_
                                                          .selectedIndexFavSelection]
                                                      .favouriteOrNot =
                                                  !_
                                                      .sentences[_
                                                          .selectedIndexFavSelection]
                                                      .favouriteOrNot;
                                              _.speakFavOrNot();
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),

              ///circularProgressIndicator
              _.showCircular.value
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
                        //todo: add the required code
                        _.selectedIndexFavSelection--;
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
                        _.selectedIndexFavSelection++;
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
                    await _.speakFavOrNot();
                  },
                  child: OttaaLogoWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
