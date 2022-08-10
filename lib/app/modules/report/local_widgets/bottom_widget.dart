import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/report/local_widgets/most_used_phrases_widget.dart';
import 'package:ottaa_project_flutter/app/modules/report/local_widgets/points_with_text.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
    required this.sevenDaysString,
    required this.averageSentenceString,
    required this.averageSentenceValue,
    required this.sevenDaysValue,
  }) : super(key: key);

  final String sevenDaysString, averageSentenceString;
  final double averageSentenceValue;
  final int sevenDaysValue;

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
            child: MostUsedPhrasesWidget(
              heading: 'Test Header',
            ),
          ),
        ],
      ),
    );
  }
}
