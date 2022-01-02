import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Container(
      padding: EdgeInsets.all(width * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose a TAG',
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
                  'By choosing TAGs you need to predict better when to show certain pictgorams, based on Time,Location, Calender or Weather',
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
      color: kOTTAOrangeNew,
      size: Get.width * 0.09,
    );
  }
}
