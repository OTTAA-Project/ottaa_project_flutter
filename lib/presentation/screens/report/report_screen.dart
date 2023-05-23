import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/report_provider.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/bottom_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/chart_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/ottaa_score_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/vocabulary_widget.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await provider.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    final verticalSize = MediaQuery.of(context).size.height;
    final provider = ref.watch(reportProvider);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
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
                      progressIndicatorScore: provider.scorePercentageScore,
                      verticalSize: verticalSize,
                      horizontalSize: horizontalSize,
                      headingText: 'ottaa_score'.trl,
                      photoUrl: provider.photoUrl,
                      scoreText: 'score_text_1'.trl,
                      level: (provider.scoreProfile ~/ 1000).toString(),
                    ),
                    SizedBox(
                      width: horizontalSize * 0.02,
                    ),
                    //todo: update the values over here from provider
                    VocabularyWidget(
                      firstValueProgress: provider.firstValueProgress,
                      secondValueProgress: provider.secondValueProgress,
                      thirdValueProgress: provider.thirdValueProgress,
                      heading: 'most_used_groups'.trl,
                      firstValueText: provider.firstValueText,
                      secondValueText: provider.secondValueText,
                      thirdValueText: provider.thirdValueText,
                      fourthValueProgress: provider.fourthValueProgress,
                      fourthValueText: provider.fourthValueText,
                      vocabularyHeading: 'vocabulary'.trl,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: verticalSize * 0.03,
                  ),
                  child: const ChartWidget(),
                ),
                BottomWidget(
                  pageController: provider.pageController,
                  averageSentenceValue: provider.averagePictoFrase == 0.00
                      ? 0.00
                      : double.parse(provider.averagePictoFrase
                          .toString()
                          .substring(0, 3)
                          .toString()),
                  sevenDaysValue: provider.frases7Days,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
