import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:picto_widget/picto_widget.dart';

class PictWidget extends StatelessWidget {
  const PictWidget({
    Key? key,
    required this.pict,
    required this.onTap,
    required this.rightOrWrong,
    required this.show,
    this.hide = false,
    this.hideText = '',
  }) : super(key: key);
  final Picto pict;
  final void Function() onTap;
  final bool rightOrWrong, show, hide;
  final String hideText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 140,
      width: 106,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 100,
              height: 122,
              padding: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                border: show
                    ? Border.all(
                        color: rightOrWrong ? Colors.green : Colors.red,
                        width: 4)
                    : Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(16),
              ),
              child: hide
                  ? Container(
                      // width: 100,
                      // height: 122,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: colorScheme.primary, width: 4),
                      ),
                      padding: const EdgeInsets.all(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          Center(
                            child: Image.asset(
                              AppImages.kGamesMark,
                              height: 46,
                              width: 46,
                            ),
                          ),
                          hideText == ''
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    hideText,
                                  ),
                                ),
                        ],
                      ),
                    )
                  : PictoWidget(
                      onTap: onTap,
                      image: pict.resource.network != null
                          ? CachedNetworkImage(
                              imageUrl: pict.resource.network!,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Image.asset(
                                fit: BoxFit.fill,
                                "assets/img/${pict.text}.webp",
                              ),
                            )
                          : Image.asset(
                              fit: BoxFit.fill,
                              "assets/img/${pict.text}.webp",
                            ),
                      text: pict.text,
                      colorNumber: pict.type,
                      width: 96,
                      height: 119,
                    ),
            ),
          ),
          show
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: rightOrWrong ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(
                        rightOrWrong ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}