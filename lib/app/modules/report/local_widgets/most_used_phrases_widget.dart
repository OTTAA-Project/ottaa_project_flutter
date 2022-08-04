import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_controller.dart';

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
              fontSize: verticalSize * 0.022,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
              child: PageView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.randomPictos.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(left:10),
                                height: 150,
                                width: 110,
                                child: Image.network(
                                    controller.randomPictos[index]),
                              );
                            },
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
