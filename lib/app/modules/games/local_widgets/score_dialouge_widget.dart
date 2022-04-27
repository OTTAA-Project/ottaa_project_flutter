import 'package:flutter/material.dart';

class ScoreDialougeWidget extends StatelessWidget {
  const ScoreDialougeWidget({
    Key? key,
    required this.horizontalSize,
    required this.verticalSize,
    required this.correct,
    required this.incorrect,
    required this.maximumStreak,
    required this.timeInSeconds,
    required this.color,
  }) : super(key: key);

  final double verticalSize, horizontalSize;
  final int correct, incorrect, timeInSeconds, maximumStreak;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        height: verticalSize * 0.4,
        width: horizontalSize * 0.4,
        decoration: BoxDecoration(
          color: Colors.blueGrey[600],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: verticalSize * 0.06,
              color: color,
              child: Center(
                child: Text(
                  'Score',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: verticalSize * 0.03,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    size: verticalSize * 0.07,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Correct',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalSize * 0.04,
                        ),
                      ),
                      Text(
                        'Incorrect',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalSize * 0.04,
                        ),
                      ),
                      Text(
                        'Use Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalSize * 0.04,
                        ),
                      ),
                      Text(
                        'Maximum Streak',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalSize * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        correct.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: verticalSize * 0.03,
                        ),
                      ),
                      Text(
                        incorrect.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: verticalSize * 0.03,
                        ),
                      ),
                      Text(
                        '${timeInSeconds / 60} m ${timeInSeconds % 60} s',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: verticalSize * 0.03,
                        ),
                      ),
                      Text(
                        maximumStreak.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: verticalSize * 0.03,
                        ),
                      ),
                    ],
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
