import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/modules/report/local_widgets/progress_painter.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class OTTAAScoreWidget extends StatelessWidget {
  const OTTAAScoreWidget({
    Key? key,
    required this.verticalSize,
    required this.horizontalSize,
    required this.headingText,
    required this.photoUrl,
    required this.progressIndicatorScore,
    required this.scoreText,
    required this.level,
  }) : super(key: key);
  final double verticalSize, horizontalSize, progressIndicatorScore;
  final String headingText, photoUrl, scoreText, level;

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                // color: Colors.pink,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headingText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: verticalSize * 0.03,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(verticalSize * 0.3),
                          color: kOTTAAOrangeNew.withOpacity(.5),
                        ),
                        child: CustomPaint(
                          painter: ProgressPainter(
                            value: progressIndicatorScore,
                            color: kOTTAAOrangeNew,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(verticalSize * 0.025),
                            decoration: BoxDecoration(),
                            height: verticalSize * 0.25,
                            width: verticalSize * 0.25,
                            child: photoUrl == ''
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        verticalSize * 0.2,
                                      ),
                                      color: Colors.grey[350],
                                    ),
                                    height: verticalSize * 0.25,
                                    width: verticalSize * 0.25,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: kOTTAAOrangeNew,
                                      ),
                                    ),
                                  )
                                : Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        verticalSize * 0.2,
                                      ),
                                    ),
                                    child: ImageWidget(url: photoUrl),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kOTTAAOrangeNew,
                      borderRadius: BorderRadius.circular(verticalSize * 0.01),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalSize * 0.04,
                      vertical: verticalSize * 0.02,
                    ),
                    child: Text(
                      'level $level',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: verticalSize * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    scoreText,
                    style: TextStyle(
                        color: Colors.black, fontSize: verticalSize * 0.018),
                    textAlign: TextAlign.center,
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

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.network(
            url,
            fit: BoxFit.fill,
          )
        : CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fill,
          );
  }
}
