import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/local_widgets/right_side_paid_version.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/local_widgets/left_side_paid_version.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';

class BuyPaidVersionPage extends GetView<HomeController> {
  const BuyPaidVersionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: controller.disposeTimerAndController,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: kOTTAAOrangeNew,
          // leading: Container(),
          foregroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () async {
              await controller.disposeTimerAndController();
            },
            child: Icon(
              Icons.arrow_back,
              size: verticalSize * 0.04,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalSize * 0.03,
            horizontal: horizontalSize * 0.02,
          ),
          child: Row(
            children: [
              /// here is the left side of the widget for the paid version screen
              const LeftSidePaidVersion(
                  // iconAddress: Ottaa_project_custom_icons.map_marked,
                  // iconAddress: Icons.videogame_asset,
                  // iconAddress: Icons.accessible_forward,
                  ),
              SizedBox(
                width: horizontalSize * 0.02,
              ),

              /// here is the right hand widget for the paid version screen
              RightSidePaidVersion(
                url: controller.paidUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
