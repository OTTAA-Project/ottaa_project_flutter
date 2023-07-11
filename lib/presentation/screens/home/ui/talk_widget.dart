import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:picto_widget/picto_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    final translations = ref.watch(homeProvider.select((value) => value.pictosTranslations));

    final size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        int pictosWord = ((size.width - (!sizingInformation.isMobile ? 500 : 200)) ~/ 64);
        return SizedBox(
          width: size.width,
          height: !sizingInformation.isMobile ? 140 : 80,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
                height: 80,
              ),
              const SizedBox(width: 32),
              Flexible(
                flex: 2,
                child: GridView.builder(
                  clipBehavior: Clip.antiAlias,
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
                      text: translations[pict.id] ?? pict.text,
                      disable: (patientNotifierState != null ? patientNotifierState.patientSettings.layout.oneToOne : false)
                          ? index == currentWord
                              ? false
                              : true
                          : false,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: !sizingInformation.isMobile ? 200 : 150,
                ),
                child: SizedBox(
                  height: !sizingInformation.isMobile ? 140 : 80,
                  child: Container(),
                ),
              ),
              const SizedBox(width: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: !sizingInformation.isMobile ? 200 : 150,
                ),
                child: SizedBox(
                  height: !sizingInformation.isMobile ? 140 : 80,
                  child: Container(),
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        );
      },
    );
  }
}
