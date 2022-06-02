import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class PictoMatchPictoWidget extends StatelessWidget {
  const PictoMatchPictoWidget({
    Key? key,
    required this.horizontalSize,
    required this.verticalSize,
    required this.left,
    required this.top,
    required this.topOrBottom,
    required this.onTap,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  final double verticalSize, horizontalSize, left, top;
  final bool topOrBottom;
  final String name, imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: top,
      // bottom: bottom,
      left: left,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(verticalSize * 0.02),
          splashColor: kOTTAAOrangeNew,
          onTap: topOrBottom ? onTap : null,
          // onTap: onTap,
          child: Container(
            height: verticalSize * 0.28,
            width: horizontalSize * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(verticalSize * 0.02),
              color: topOrBottom ? Colors.transparent : Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                      verticalSize * 0.01,
                      verticalSize * 0.01,
                      verticalSize * 0.01,
                      0,
                    ),
                    padding: EdgeInsets.all(
                      verticalSize * 0.01,
                    ),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(verticalSize * 0.03),
                      border: Border.all(
                          color: Colors.black, width: verticalSize * 0.01),
                    ),
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
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: verticalSize * 0.042,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      duration: Duration(seconds: 1),
    );
  }
}
