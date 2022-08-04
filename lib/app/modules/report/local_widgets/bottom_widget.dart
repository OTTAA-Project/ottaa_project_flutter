import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/report/local_widgets/points_with_text.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key}) : super(key: key);

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
                    description: 'Test Description ',
                    score: '20.90',
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
                    description: 'Test Description ',
                    score: '20.90',
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
