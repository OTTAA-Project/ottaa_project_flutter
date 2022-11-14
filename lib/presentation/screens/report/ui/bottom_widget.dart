import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/most_used_phrases_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/points_with_text.dart';

import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
    required this.sevenDaysString,
    required this.averageSentenceString,
    required this.averageSentenceValue,
    required this.sevenDaysValue,
    required this.pageController,
  }) : super(key: key);

  final String sevenDaysString, averageSentenceString;
  final double averageSentenceValue;
  final int sevenDaysValue;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      height: verticalSize * 0.3,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PointsWithText(
                    boxColor: kOTTAAOrangeNew,
                    textColor: Colors.white,
                    description: sevenDaysString,
                    score: sevenDaysValue.toString(),
                  ),
                ),
                SizedBox(
                  width: horizontalSize * 0.02,
                ),
                Expanded(
                  flex: 1,
                  child: PointsWithText(
                    boxColor: Colors.white,
                    textColor: kOTTAAOrangeNew,
                    description: averageSentenceString,
                    score: averageSentenceValue.toString(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: horizontalSize * 0.02,
          ),
          Expanded(
            flex: 1,
            child: MostUsedPhrasesWidget(pageController: pageController),
          ),
        ],
      ),
    );
  }
}
