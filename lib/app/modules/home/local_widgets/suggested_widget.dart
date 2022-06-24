import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/buy_paid_version_page.dart';
import 'package:ottaa_project_flutter/app/global_widgets/picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import '../../../utils/CustomAnalytics.dart';

class SuggestedWidget extends StatelessWidget {
  SuggestedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
      id: "suggested",
      builder: (_) => Bounce(
        from: 5,
        duration: Duration(seconds: 1),
        controller: (controller) => _.pictoAnimationController = controller,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: verticalSize * 0.52,
              width: horizontalSize * 0.78,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _.suggestedQuantity,
                itemBuilder: (BuildContext context, int index) {
                  if (_.suggestedPicts.isNotEmpty) {
                    final Pict pict = _.suggestedPicts[
                        index + _.suggestedIndex * _.suggestedQuantity];
                    return Container(
                      margin: EdgeInsets.all(horizontalSize / 99),
                      child: Picto(
                        localImg: pict.localImg,
                        height: verticalSize * 0.10,
                        width: horizontalSize * 0.175,
                        pict: pict,
                        languaje: _.ttsController.languaje,
                        onLongPress: pict.localImg
                            ? () {}
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: ChoiceDialogue(
                                        index: pict.id,
                                        suggestedIndexMainScreen: index +
                                            _.suggestedIndex *
                                                _.suggestedQuantity,
                                      ),
                                    );
                                  },
                                );
                              },
                        onTap: () {
                          if (pict.texto.es != "agregar") {
                            _.addPictToSentence(pict);
                          } else {
                            if (_.sentencePicts.length == 0) {
                              _.toId = 0;
                              _.fromAdd = true;
                            } else {
                              _.toId = _.sentencePicts.last.id;
                              _.fromAdd = true;
                            }
                            Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                            CustomAnalyticsEvents.setEventWithParameters(
                                "Touch",
                                CustomAnalyticsEvents.createMyMap(
                                    'Principal', 'Group Gallery'));
                          }
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceDialogue extends StatelessWidget {
  ChoiceDialogue({Key? key, this.index, required this.suggestedIndexMainScreen})
      : super(key: key);
  int? index;
  final _homeController = Get.find<HomeController>();
  final int suggestedIndexMainScreen;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (_homeController.userSubscription == 1) {
                _homeController.suggestedMainScreenIndex =
                    suggestedIndexMainScreen;
                _homeController.editPicto(
                  suggestedIndexMainScreen: suggestedIndexMainScreen,
                );
              } else {
                _homeController.initializePageViewer();
                Get.to(() => BuyPaidVersionPage());
              }
            },
            child: Text('edit'.tr),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              if (_homeController.userSubscription == 1) {
                _homeController.deletePicto(
                  index: index!,
                  context: context,
                  suggestedIndexMainScreen: suggestedIndexMainScreen,
                );
              } else {
                _homeController.initializePageViewer();
                Get.to(() => BuyPaidVersionPage());
              }
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
