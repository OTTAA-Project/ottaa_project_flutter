import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewerContainer extends StatelessWidget {
  const PageViewerContainer({
    Key? key,
    required this.color,
    required this.subtitle,
    required this.title,
    required this.verticalSize,
    required this.horizontalSize,
    required this.completedLevel,
    required this.totalLevel,
    required this.imageAsset,
  }) : super(key: key);
  final Color color;
  final String title, subtitle, imageAsset;
  final int completedLevel, totalLevel;
  final double verticalSize, horizontalSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(verticalSize * 0.02),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalSize * 0.015,
        vertical: verticalSize * 0.015,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(verticalSize * 0.02),
                  topRight: Radius.circular(verticalSize * 0.02),
                ),
              ),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: verticalSize * 0.025,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: verticalSize * 0.02,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Level $completedLevel/$totalLevel',
                      style: TextStyle(
                        fontSize: verticalSize * 0.025,
                        color: color,
                      ),
                    ),
                    Text(
                      'play'.tr,
                      style: TextStyle(
                        fontSize: verticalSize * 0.025,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
