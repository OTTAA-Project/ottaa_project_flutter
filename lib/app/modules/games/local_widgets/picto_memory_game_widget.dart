import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class PictoMemoryGameWidget extends StatelessWidget {
  const PictoMemoryGameWidget({
    Key? key,
    required this.onTap,
    required this.verticalSize,
    required this.name,
    required this.horizontalSize,
    required this.imageUrl,
    required this.showOrHide,
    required this.left,
    required this.bottom,
    required this.top,
  }) : super(key: key);
  final double verticalSize, horizontalSize, left;
  final double? top, bottom;
  final String name, imageUrl;
  final void Function()? onTap;
  final bool showOrHide;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: kOTTAAOrangeNew,
          onTap: showOrHide ? null : onTap,
          child: Container(
            height: verticalSize * 0.4,
            width: horizontalSize * 0.2,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(verticalSize * 0.02),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                      verticalSize * 0.02,
                      verticalSize * 0.02,
                      verticalSize * 0.02,
                      0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(verticalSize * 0.02),
                      border: Border.all(
                        color: Colors.black,
                        width: verticalSize * 0.01,
                      ),
                    ),
                    child: showOrHide
                        ? kIsWeb
                            ? Image.network(imageUrl)
                            : CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                                fit: BoxFit.fill,
                              )
                        : Icon(
                            Icons.help_outline,
                            color: kOTTAAOrangeNew,
                            size: verticalSize * 0.14,
                          ),
                  ),
                ),
                Text(
                  showOrHide ? name : '',
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
    );
  }
}
