import 'package:flutter/material.dart';

class PointsWithText extends StatelessWidget {
  const PointsWithText({
    Key? key,
    required this.boxColor,
    required this.textColor,
    required this.description,
    required this.score,
  }) : super(key: key);
  final Color boxColor, textColor;
  final String score, description;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(
          verticalSize * 0.01,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            score,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: verticalSize * 0.06,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: verticalSize * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
