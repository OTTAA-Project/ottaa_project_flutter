import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';

import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/bottom_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/chart_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/ottaa_score_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/vocabulary_widget.dart';

class ReportPage extends StatelessWidget {
  ReportPage({Key? key}) : super(key: key);
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: kOTTAAOrangeNew,
        title: Text('report'.trl),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  children: [
                    //todo: update the values init
                    OTTAAScoreWidget(
                      progressIndicatorScore:
                          controller.scorePercentageScore.value,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      headingText: 'ottaa_score'.trl,
                      photoUrl: controller.photoUrl.value,
                      scoreText: 'score_text_1'.trl,
                      level: ((controller.scoreProfile / 1000).toInt())
                          .toStrling(),
                    ),
                    SizedBox(
                      width: horizontalSize * 0.02,
                    ),
                    //todo: update the values over here from provider
                    VocabularyWidget(
                      firstValueProgress: controller.firstValueProgress.value,
                      secondValueProgress: controller.secondValueProgress.value,
                      thirdValueProgress: controller.thirdValueProgress.value,
                      heading: 'most_used_groups'.trl,
                      firstValueText: controller.firstValueText.value,
                      secondValueText: controller.secondValueText.value,
                      thirdValueText: controller.thirdValueText.value,
                      fourthValueProgress: controller.fourthValueProgress.value,
                      fourthValueText: controller.fourthValueText.value,
                      vocabularyHeading: 'vocabulary'.trl,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: verticalSize * 0.03,
                  ),
                  child: ChartWidget(),
                ),
                BottomWidget(
                  pageController: pageController,
                  averageSentenceString: 'pictogram_by_sentence_on_average'.trl,
                  averageSentenceValue:
                      controller.averagePictoFrase.value == 0.00
                          ? 0.00
                          : double.parse(controller.averagePictoFrase.value
                              .toStrling()
                              .substrling(0, 3)
                              .toStrling()),
                  sevenDaysString: 'phrases_last_seven_days'.trl,
                  sevenDaysValue: controller.frases7Days.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
