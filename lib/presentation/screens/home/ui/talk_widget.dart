import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/sweep_modes.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';
import 'package:collection/collection.dart';

class TalkWidget extends ConsumerStatefulWidget {
  const TalkWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TalkWidgetState();
}

class _TalkWidgetState extends ConsumerState<TalkWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pictoWords = ref.watch(homeProvider).pictoWords;
    final int? currentWord = ref.watch(homeProvider).selectedWord;
    final patientNotifierState = ref.watch(patientNotifier);
    final scrollCon = ref.watch(homeProvider).scrollController;

    final size = MediaQuery.of(context).size;

    int pictosWord = ((size.width - 500) ~/ 64);

    return SizedBox(
      width: size.width,
      height: kIsTablet ? 140 : 80,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 80,
          ),
          const SizedBox(width: 32),
          Flexible(
            flex: 2,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pictoWords.length + pictosWord,
              controller: scrollCon,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 16,
                childAspectRatio: 4 / 3,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                Picto? pict = pictoWords.firstWhereIndexedOrNull((elIndex, element) => elIndex == index);

                if (pict == null) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      height: 119,
                      width: 96,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  );
                }
                return PictoWidget(
                  width: 64,
                  height: 140,
                  onTap: () {},
                  colorNumber: pict.type,
                  image: pict.resource.network != null
                      ? CachedNetworkImage(
                          imageUrl: pict.resource.network!,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: colorScheme.primary,
                                value: progress.totalSize != null ? progress.downloaded / progress.totalSize! : null,
                              ),
                            );
                          },
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
                  disable: (patientNotifierState != null ? patientNotifierState.patientSettings.layout.oneToOne : false)
                      ? false
                      : index == currentWord
                          ? false
                          : true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
