import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/report/local_widgets/ottaa_score_widget.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_controller.dart';

class ReportPage extends GetView<ReportController> {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  children: [
                    Obx(
                      () => OTTAAScoreWidget(
                        progressIndicatorScore:
                            controller.scorePercentageScore.value,
                        verticalSize: verticalSize,
                        horizontalSize: horizontalSize,
                        headingText: 'ottaa_score'.tr,
                        photoUrl: controller.photoUrl.value,
                      ),
                    ),
                    SizedBox(
                      width: horizontalSize * 0.02,
                    ),
                    Expanded(
                      child: Container(
                        height: verticalSize * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            verticalSize * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
