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

class TalkWidget extends ConsumerStatefulWidget {
  const TalkWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TalkWidgetState();
}

class _TalkWidgetState extends ConsumerState<TalkWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      int pictoSize = 64;

      int pictoCount = ((size.height - 390) / pictoSize).floor();

      ref.read(homeProvider.select((value) => value.setWordQuantity))(
          pictoCount);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    int pictoSize = 64;

    int pictoCount = ((size.width - 390) / pictoSize).floor();

    final pictoWords = ref.watch(homeProvider).pictoWords;
    final currentWord = ref.watch(homeProvider).selectedWord;
    final pictosIsEmpty = pictoWords.isEmpty;

    final removeLastPictogram =
        ref.read(homeProvider.select((value) => value.removeLastPictogram));
    return Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          width: 20,
          height: 80,
        ),
        const SizedBox(width: 32),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                  pictoCount,
                  (index) {
                    Picto? pict = pictoWords.firstWhereIndexedOrNull(
                        (elIndex, element) => elIndex == index);

                    if (pict == null) {
                      return Container(
                        width: 64,
                        height: 140,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      );
                    }

                    return PictoWidget(
                      width: 64,
                      height: 140,
                      onTap: () {},
                      image: pict.resource.network != null
                          ? CachedNetworkImage(
                              imageUrl: pict.resource.network!,
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: colorScheme.primary,
                                    value: progress.totalSize != null
                                        ? progress.downloaded /
                                            progress.totalSize!
                                        : null,
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

                      /// add disabled here for the widgets
                      disable: currentWord == pict.text ? false : true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const SizedBox(
          width: 138,
          height: 80,
        ),
        const SizedBox(width: 16),
        const SizedBox(
          width: 138,
          height: 80,
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
