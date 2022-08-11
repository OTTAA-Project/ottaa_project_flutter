import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/report/local_widgets/progress_painter.dart';

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
  }) : super(key: key);
  final double firstValueProgress,
      secondValueProgress,
      thirdValueProgress,
      fourthValueProgress;
  final String firstValueText, secondValueText, thirdValueText, fourthValueText;
  final String heading;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: verticalSize * 0.35,
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
                    'Vocabulary',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        ///first one
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: firstValueProgress,
                              color: Colors.amberAccent,
                            ),
                            child: Container(
                              height: 250,
                              width: 250,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: Container(
                              height: 220,
                              width: 220,
                            ),
                          ),
                        ),

                        /// second value
                        Padding(
                          padding: const EdgeInsets.only(top: 25, left: 25),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: secondValueProgress,
                                color: Colors.brown,
                              ),
                              child: Container(
                                height: 200,
                                width: 200,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, top: 40),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: Container(
                              height: 170,
                              width: 170,
                            ),
                          ),
                        ),

                        /// third value
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                            top: 50,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            height: 150,
                            width: 150,
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: thirdValueProgress,
                                color: Colors.pink,
                              ),
                              child: Container(
                                height: 150,
                                width: 150,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 65, top: 65),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: Container(
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),

                        /// fourth value
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 75,
                            top: 75,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            height: 100,
                            width: 100,
                            child: CustomPaint(
                              painter: ProgressPainter(
                                value: fourthValueProgress,
                                color: Colors.blue,
                              ),
                              child: Container(
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90, top: 90),
                          child: CustomPaint(
                            painter: ProgressPainter(
                              value: 100,
                              color: Colors.white,
                            ),
                            child: Container(
                              height: 70,
                              width: 70,
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
                    padding:
                        EdgeInsets.symmetric(vertical: verticalSize * 0.02),
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
                    padding:
                        EdgeInsets.symmetric(vertical: verticalSize * 0.01),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SmallCircularWidget(color: color),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black),
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
    return CustomPaint(
      painter: ProgressPainter(color: color, value: 100),
      child: Container(
        height: 30,
        width: 30,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomPaint(
            painter: ProgressPainter(value: 100, color: Colors.white),
            child: Container(
              height: 15,
              width: 15,
            ),
          ),
        ),
      ),
    );
  }
}
