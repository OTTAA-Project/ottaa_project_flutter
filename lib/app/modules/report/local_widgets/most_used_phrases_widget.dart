import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class MostUsedPhrasesWidget extends StatelessWidget {
  MostUsedPhrasesWidget({
    Key? key,
    required this.heading,
  }) : super(key: key);
  final String heading;
  final controller = Get.find<ReportController>();

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          verticalSize * 0.01,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              // fontSize: verticalSize * 0.022,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: 4,
                itemBuilder: (context, indexMain) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(
                        horizontalSize * 0.01,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        controller.loadingMostUsedSentences.value
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: controller
                                      .mostUsedSentences[indexMain].length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, indexSecond) {
                                    return Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height: 150,
                                      width: 110,
                                      child: Image.network(controller
                                              .mostUsedSentences[indexMain]
                                          [indexSecond]),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: kOTTAAOrangeNew,
                                  ),
                                ),
                              ),
                        Align(
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: verticalSize * 0.03),
                            child: Image.asset(
                              'assets/otta_drawer_logo.png',
                              height: verticalSize * 0.05,
                            ),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
