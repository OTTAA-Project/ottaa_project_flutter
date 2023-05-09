import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';
import 'package:collection/collection.dart';
import 'package:universal_io/io.dart';

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

  Widget buildExitButton({required HomeScreenStatus status}) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case HomeScreenStatus.pictos:
        return Row(
          children: [
            GestureDetector(
              onLongPressEnd: (details) {
                //TODO: Show back dialog :)
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
          ],
        );
      case HomeScreenStatus.grid:
      case HomeScreenStatus.tabs:
        return Row(
          children: [
            const SizedBox(width: 0),
            SizedBox(
              width: 40,
              height: 40,
              child: HomeButton(
                onPressed: () {
                  if (status == HomeScreenStatus.tabs) {
                    ref.read(homeProvider).status = HomeScreenStatus.pictos;
                  } else {
                    ref.read(homeProvider).currentGridGroup != null ? ref.read(homeProvider).currentGridGroup = null : ref.read(homeProvider).status = HomeScreenStatus.pictos;
                  }
                  ref.read(homeProvider).notify();
                },
                size: const Size(40, 40),
                child: const Icon(Icons.close_rounded),
              ),
            ),
            const SizedBox(width: 12),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pictoWords = ref.watch(homeProvider).pictoWords;
    final int? selectedWord = ref.watch(homeProvider).selectedWord;
    final show = ref.watch(homeProvider).show;

    final pictosIsEmpty = pictoWords.isEmpty;
    final scrollCon = ref.watch(homeProvider).scrollController;

    final removeLastPictogram = ref.read(homeProvider.select((value) => value.removeLastPictogram));

    final status = ref.watch(homeProvider.select((value) => value.status));
    final size = MediaQuery.of(context).size;

    int pictosWord = ((size.width - (kIsTablet ? 500 : 200)) ~/ 64);
    print(kIsTablet);
    return SizedBox(
      width: size.width,
      height: kIsTablet ? 140 : 80,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildExitButton(status: status),
          Flexible(
            flex: 2,
            child: Scrollbar(
              controller: scrollCon,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    disable: show && selectedWord == index ? true : false,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: kIsTablet ? 200 : 150,
            ),
            child: SizedBox(
              height: kIsTablet ? 140 : 80,
              child: ElevatedButton(
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
                child: Center(
                  child: Image.asset(
                    pictosIsEmpty ? AppImages.kDelete : AppImages.kDeleteOrange,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: kIsTablet ? 200 : 150,
            ),
            child: SizedBox(
              height: kIsTablet ? 140 : 80,
              child: ElevatedButton(
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
                onPressed: () async {
                  await ref.read(homeProvider.notifier).speakSentence();
                },
                child: Center(
                  child: Image.asset(
                    AppImages.kOttaaMinimalist,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
