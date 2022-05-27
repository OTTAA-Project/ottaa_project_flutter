import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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
    required this.onTap,
  }) : super(key: key);

  final double verticalSize, horizontalSize;
  final String imageUrl, name, selectedAnswer;
  final bool imageOrResult;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: Stack(
                children: [
                  Center(
                    child: kIsWeb
                        ? Image.network(imageUrl)
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                  Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1000),
                      opacity: imageOrResult ? 0 : 1,
                      child: selectedAnswer.toUpperCase() == name.toUpperCase()
                          ? Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.orange,
                              size: verticalSize * 0.2,
                            )
                          : Icon(
                              Icons.thumb_down,
                              color: Colors.orange,
                              size: verticalSize * 0.2,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: verticalSize * 0.03),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: verticalSize * 0.02,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
