import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/drawer_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/right_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/actions_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/left_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/sentence_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/suggested_widget.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/local_widgets/otta_logo_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:screenshot/screenshot.dart';
import '../../utils/CustomAnalytics.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // key: _homeController.scaffoldKey,
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          /// ScreenSHot Widget is here
          Screenshot(
            controller: controller.screenshotController,
            child: Container(
              height: verticalSize * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: GetBuilder<HomeController>(
                      id: 'screenshot',
                      builder: (controller) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.sentencePicts.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: verticalSize * 0.01),
                          child: kIsWeb
                              ? Image.network(
                            controller.sentencePicts[index].imagen
                                .pictoEditado ==
                                null
                                ? controller
                                .sentencePicts[index].imagen.picto
                                : controller.sentencePicts[index].imagen
                                .pictoEditado!,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kOTTAAOrangeNew,
                                  value:
                                  loadingProgress.expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          )
                              : CachedNetworkImage(
                            imageUrl: controller.sentencePicts[index].imagen
                                .pictoEditado ==
                                null
                                ? controller
                                .sentencePicts[index].imagen.picto
                                : controller.sentencePicts[index].imagen
                                .pictoEditado!,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            height: verticalSize * 0.04,
                            width: verticalSize * 0.15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: verticalSize * 0.03),
                    child: Image.asset(
                      'assets/otta_drawer_logo.png',
                      height: verticalSize * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// just a little hack to keep it hidden
          Container(
            height: verticalSize * 0.25,
            color: Colors.black,
          ),
          Column(
            //MAIN COLUMN
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // TOP ROW
              SentenceWidget(),
              Row(
                // BODY ROW
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LEFT COLUMN
                  LeftColumnWidget(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // BODY
                      SuggestedWidget(),
                      ActionsWidget(),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  // RIGHT COLUMN
                  RightColumnWidget(),
                ],
              )
              //SizedBox(height: 10),
            ],
          ),
          GetBuilder<HomeController>(
            id: "subtitle",
            builder: (_homeController) {
              if (_homeController.hasText())
                return Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 13,
                        ),
                        ClipRRect(
                          child: Image(
                            image: AssetImage('assets/Group 671.png'),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            _ttsController.isCustomSubtitle
                                ? _ttsController.isSubtitleUppercase
                                    ? _homeController.voiceText.toUpperCase()
                                    : _homeController.voiceText
                                : _homeController.voiceText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _ttsController.isCustomSubtitle
                                  ? verticalSize *
                                      ((_ttsController.subtitleSize / 100) +
                                          0.01)
                                  : verticalSize * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    width: horizontalSize * 0.35,
                    height: verticalSize * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                );
              return Container();
            },
          ),
          Positioned(
            left: horizontalSize * 0.43,
            right: horizontalSize * 0.43,
            bottom: verticalSize * 0.02,
            child: GestureDetector(
              onTap: () {
                if (_homeController.sentencePicts.length == 0)
                  Fluttertoast.showToast(
                    msg: "choose_a_picto_to_speak".tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: verticalSize * 0.03,
                  );
                _homeController.speak();
                CustomAnalyticsEvents.setEventWithParameters("Touch",
                    CustomAnalyticsEvents.createMyMap('Principal', 'Talk'));
              },
              child: OttaLogoWidget(),
            ),
          ),
          /*Positioned(
                right: 0,
                top: verticalSize * 0.25,
                child: FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.SETTINGS);
                    },
                    child: Center(
                      child: Icon(
                        Icons.settings,
                        color: Colors.transparent,
                        size: horizontalSize / 10,
                      ),
                    ),
                  ),
                ),
              ),*/
          // if (_homeController.isPlaying())
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
