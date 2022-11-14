import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'choose_a_tag'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[600],
                      fontSize: width * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'tags_widget_long_1'.tr,
                  style: TextStyle(),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconWidget(icon: Icons.timer),
                    iconWidget(icon: Icons.location_on),
                    iconWidget(icon: Icons.face),
                    iconWidget(icon: Icons.wc),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconWidget({required IconData icon}) {
    return Icon(
      icon,
      color: kOTTAAOrangeNew,
      size: Get.width * 0.09,
    );
  }
}
