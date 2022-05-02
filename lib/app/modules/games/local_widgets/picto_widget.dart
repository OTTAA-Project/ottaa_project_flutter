import 'package:flutter/material.dart';

class PictoWidget extends StatelessWidget {
  const PictoWidget({
    Key? key,
    required this.verticalSize,
    required this.horizontalSize,
    required this.imageUrl,
    required this.name,
    required this.imageOrResult,
    required this.selectedAnswer,
  }) : super(key: key);

  final double verticalSize, horizontalSize;
  final String imageUrl, name, selectedAnswer;
  final bool imageOrResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: verticalSize * 0.5,
      width: horizontalSize * 0.2,
      padding: EdgeInsets.all(verticalSize * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(verticalSize * 0.02),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: horizontalSize * 0.19,
            height: verticalSize * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(verticalSize * 0.02),
              border: Border.all(
                color: Colors.lightGreenAccent,
                width: 4,
              ),
            ),
            //todo: replace it with the imageWidget
            child: Center(
              child: imageOrResult
                  ? Image.asset('assets/icono_ottaa.webp')
                  : AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: imageOrResult ? 0 : 1,
                      child: Icon(
                        selectedAnswer.toUpperCase() == name.toUpperCase()
                            ? Icons.emoji_emotions_outlined
                            : Icons.thumb_down,
                        color: Colors.orange,
                        size: verticalSize * 0.2,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: verticalSize * 0.03),
            child: Text(
              'Example of the text',
              style: TextStyle(
                fontSize: verticalSize * 0.02,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
