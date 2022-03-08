import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class SearchSentence extends GetView<SentencesController> {
  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<SentencesController>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kOTTAOrangeNew,
          leading: Container(),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text('all_phrases'.tr),
          actions: [
            Obx(
              () => controller.searchOrIcon.value
                  ? Container(
                      padding: EdgeInsets.only(right: horizontalSize * 0.04),
                      width: horizontalSize * 0.3,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                hintText: '${'search'.tr}...',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                controller.onChangedText(v);
                              },
                            ),
                          ),
                          SizedBox(
                            width: horizontalSize * 0.02,
                          ),
                          GestureDetector(
                            onTap: () => controller.searchOrIcon.value = false,
                            child: Icon(
                              Icons.clear,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        right: horizontalSize * 0.02,
                      ),
                      child: GestureDetector(
                        onTap: () => controller.searchOrIcon.value = true,
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: horizontalSize * .10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalSize * 0.02),
                        child: Center(
                          child: GetBuilder<SentencesController>(
                            id: "searchBuilder",
                            builder: (_) => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _.sentencesForList.isNotEmpty
                                      ? Container(
                                          height: verticalSize / 3,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _
                                                    .sentencesPicts[_
                                                        .sentencesForList[
                                                            _.searchIndex]
                                                        .index]
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
                                                      .sentencesPicts[_
                                                          .sentencesForList[
                                                              _.searchIndex]
                                                          .index]
                                                      .length >
                                                  index) {
                                                final Pict pict =
                                                    _.sentencesPicts[_
                                                        .sentencesForList[
                                                            _.searchIndex]
                                                        .index][index];
                                                return Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: MiniPicto(
                                                    localImg: pict.localImg,
                                                    pict: pict,
                                                    onTap: () {
                                                      _.searchSpeak();
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
                                                        _.searchSpeak();
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        )
                                      : Container(
                                          child: Center(
                                            child: Text(
                                              'please_enter_a_valid_search'.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: kOTTAOrangeNew,
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
                            Container(),
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
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: kOTTAOrangeNew,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                    ),
                  ),
                  width: horizontalSize * 0.10,
                  height: verticalSize * 0.5,
                  child: Center(
                    child: GestureDetector(
                      onTap: controller.decrementOne,
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
                    color: kOTTAOrangeNew,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  width: horizontalSize * 0.10,
                  height: verticalSize * 0.5,
                  child: Center(
                    child: GestureDetector(
                      onTap: controller.incrementOne,
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
                    await controller.searchSpeak();
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
