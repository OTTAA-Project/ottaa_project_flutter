import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class FavouriteScreenPage extends GetView<SentencesController> {
  const FavouriteScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<SentencesController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: kOTTAAOrangeNew,
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text("favourites_sente".tr),
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.ADDORREMOVEFAVOURITEPAGE,
              ),
              child: Icon(
                Icons.favorite,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
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
                              //todo: add the callback and also change the icon on the click and view
                              onTap: () => Get.toNamed(
                                AppRoutes.ADDORREMOVEFAVOURITEPAGE,
                              ),
                              child: Icon(
                                Icons.edit,
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
                  width: horizontalSize * 0.8,
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
                        id: "favourite_sentences",
                        builder: (_) => Container(
                          height: verticalSize * 0.8,
                          width: horizontalSize * 0.8,
                          // padding: EdgeInsets.symmetricmmetric(
                          //     horizontal: horizontalSize * 0.12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _.favouriteSentences.isNotEmpty
                                    ? Container(
                                        height: verticalSize / 3,
                                        width: horizontalSize * 0.78,
                                        padding: EdgeInsets.symmetric(
                                            vertical: verticalSize * 0.05),
                                        child: Center(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _
                                                    .favouritePicts[_
                                                        .selectedIndexFav]
                                                    .length +
                                                1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final Pict speakPict = Pict(
                                                localImg: true,
                                                id: 0,
                                                texto: Texto(),
                                                tipo: 6,
                                                imagen: Imagen(
                                                    picto: "logo_ottaa_dev"),
                                              );
                                              if (_
                                                      .favouritePicts[_
                                                          .selectedIndexFav]
                                                      .length >
                                                  index) {
                                                final Pict pict = _
                                                            .favouritePicts[
                                                        _.selectedIndexFav]
                                                    [index];
                                                return Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: MiniPicto(
                                                    localImg: pict.localImg,
                                                    pict: pict,
                                                    onTap: () {
                                                      _.speakFavOrNot();
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: MiniPicto(
                                                    localImg:
                                                        speakPict.localImg,
                                                    pict: speakPict,
                                                    onTap: () {
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
                    ),
                  ),
                ),
              ),

              ///circularProgressIndicator
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
                        //todo: add the required code
                        controller.selectedIndexFav--;
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
                        //todo: add the required code
                        controller.selectedIndexFav++;
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
                    //todo: add the required code
                    await controller.speak();
                  },
                  child: OttaaLogoWidget(),
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
