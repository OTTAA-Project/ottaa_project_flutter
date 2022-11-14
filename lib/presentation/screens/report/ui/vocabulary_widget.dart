import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/ui/progress_painter.dart';

class VocabularyWidget extends StatelessWidget {
  const VocabularyWidget({
    Key? key,
    required this.thirdValueProgress,
    required this.secondValueProgress,
    required this.firstValueProgress,
    required this.heading,
    required this.firstValueText,
    required this.secondValueText,
    required this.thirdValueText,
    required this.fourthValueProgress,
    required this.fourthValueText,
    required this.vocabularyHeading,
  }) : super(key: key);

  final double firstValueProgress, secondValueProgress, thirdValueProgress, fourthValueProgress;
  final String firstValueText, secondValueText, thirdValueText, fourthValueText, heading, vocabularyHeading;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    // final horizontalSize = MediaQuery.of(context).size.width;
    // print('the vertical size is ${verticalSize.toString()}');
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: verticalSize * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            verticalSize * 0.02,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vocabularyHeading,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        ///first one
                        Padding(
                          padding: EdgeInsets.only(left: verticalSize * 0.005, top: verticalSize * 0.005),
                          child: Container(
                            height: verticalSize * 0.29,
                            width: verticalSize * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: firstValueProgress,
                                color: Colors.amberAccent,
                              ),
                              child: SizedBox(
                                height: verticalSize * 0.29,
                                width: verticalSize * 0.29,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: verticalSize * 0.025, top: verticalSize * 0.025),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: verticalSize * 0.25,
                              width: verticalSize * 0.25,
                            ),
                          ),
                        ),

                        /// second value
                        Padding(
                          padding: EdgeInsets.only(top: verticalSize * 0.04, left: verticalSize * 0.04),
                          child: Container(
                            height: verticalSize * 0.22,
                            width: verticalSize * 0.22,
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: secondValueProgress,
                                color: Colors.brown,
                              ),
                              child: SizedBox(
                                height: verticalSize * 0.22,
                                width: verticalSize * 0.22,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: verticalSize * 0.06, top: verticalSize * 0.06),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: verticalSize * 0.18,
                              width: verticalSize * 0.18,
                            ),
                          ),
                        ),

                        /// third value
                        Padding(
                          padding: EdgeInsets.only(
                            left: verticalSize * 0.075,
                            top: verticalSize * 0.075,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            height: verticalSize * 0.15,
                            width: verticalSize * 0.15,
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: thirdValueProgress,
                                color: Colors.pink,
                              ),
                              child: SizedBox(
                                height: verticalSize * 0.15,
                                width: verticalSize * 0.15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: verticalSize * 0.095, top: verticalSize * 0.095),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: verticalSize * 0.11,
                              width: verticalSize * 0.11,
                            ),
                          ),
                        ),

                        /// fourth value
                        Padding(
                          padding: EdgeInsets.only(
                            left: verticalSize * 0.108,
                            top: verticalSize * 0.108,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            height: verticalSize * 0.085,
                            width: verticalSize * 0.085,
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: fourthValueProgress,
                                color: Colors.blue,
                              ),
                              child: SizedBox(
                                height: verticalSize * 0.085,
                                width: verticalSize * 0.085,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: verticalSize * 0.122, top: verticalSize * 0.122),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: verticalSize * 0.055,
                              width: verticalSize * 0.055,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: verticalSize * 0.02),
                    child: Text(
                      heading,
                    ),
                  ),
                  RowWidget(
                    color: Colors.amberAccent,
                    text: firstValueText,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: verticalSize * 0.01),
                    child: RowWidget(
                      color: Colors.brown,
                      text: secondValueText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: verticalSize * 0.01),
                    child: RowWidget(
                      color: Colors.pink,
                      text: thirdValueText,
                    ),
                  ),
                  RowWidget(
                    color: Colors.blue,
                    text: fourthValueText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SmallCircularWidget(color: color),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: verticalSize * 0.02),
        ),
      ],
    );
  }
}

class SmallCircularWidget extends StatelessWidget {
  const SmallCircularWidget({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    // final horizontalSize = MediaQuery.of(context).size.width;
    return CustomPaint(
      painter: ProgressPainter(color: color, value: 100),
      child: SizedBox(
        height: verticalSize * 0.05,
        width: verticalSize * 0.05,
        child: Padding(
          padding: EdgeInsets.all(verticalSize * 0.01),
          child: CustomPaint(
            painter: ProgressPainter(value: 100, color: Colors.white),
            child: SizedBox(
              height: verticalSize * 0.03,
              width: verticalSize * 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
