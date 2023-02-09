import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';
import 'package:collection/collection.dart';

class WordBarUI extends ConsumerStatefulWidget {
  const WordBarUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WordBarUIState();
}

class _WordBarUIState extends ConsumerState<WordBarUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    int pictoSize = 64;

    int pictoCount = ((size.width - 390) / pictoSize).floor();

    final pictoWords = ref.watch(homeProvider).pictoWords;

    final pictosIsEmpty = pictoWords.isEmpty;

    final removeLastPictogram = ref.read(homeProvider.select((value) => value.removeLastPictogram));
    return Flex(
      direction: Axis.horizontal,
      children: [
        GestureDetector(
          onLongPressEnd: (details) {
            context.pop();
          },
          child: Container(
            width: 20,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pictoWords.length + 6,
            itemBuilder: (context, index) {
              Picto? pict = pictoWords.firstWhereIndexedOrNull((elIndex, element) => elIndex == index);

              if (pict == null) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    width: 64,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PictoWidget(
                  width: 64,
                  height: 140,
                  onTap: () {},
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
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 138,
          height: 80,
          child: BaseButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(pictosIsEmpty ? Colors.grey.withOpacity(.12) : Colors.white),
              overlayColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.1)),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: pictosIsEmpty ? null : removeLastPictogram,
            child: Image.asset(
              pictosIsEmpty ? AppImages.kDelete : AppImages.kDeleteOrange,
              width: 59,
              height: 59,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 138,
          height: 80,
          child: BaseButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(pictosIsEmpty ? colorScheme.primary.withOpacity(.12) : colorScheme.primary),
              overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () {
              ref.read(homeProvider.notifier).speakSentence();
            },
            child: Image.asset(
              AppImages.kOttaaMinimalist,
              color: Colors.white,
              width: 59,
              height: 59,
            ),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
