import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/resource_image.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/shortcuts_ui.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class HomeGridUI extends ConsumerStatefulWidget {
  const HomeGridUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsHomeUi();
}

class _GroupsHomeUi extends ConsumerState<HomeGridUI> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    final groups = ref.watch(homeProvider).groups.values.where((element) => !element.block).toList();

    final addPictogram = ref.read(homeProvider.select((value) => value.addPictogram));

    String? currentGroup = ref.watch(homeProvider).currentGridGroup;

    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
          ),
          child: Text(
            (currentGroup == null
                ? "home.grid.title".trl
                : "home.grid.pictos".trlf({
                    "group": ref.watch(homeProvider).groups[currentGroup]!.text,
                  })),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 8,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 8,
                child: currentGroup == null
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                          mainAxisExtent: 96,
                        ),
                        controller: ref.watch(homeProvider.select((value) => value.gridScrollController)),
                        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32),
                        itemCount: groups.length,
                        itemBuilder: (ctx, index) {
                          Group group = groups[index];

                          return ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(size),
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              foregroundColor: MaterialStateProperty.all(kBlackColor),
                              iconColor: MaterialStateProperty.all(colorScheme.secondary),
                              overlayColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.1)),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                              // padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: () {
                              ref.read(homeProvider).currentGridGroup = group.id;
                              ref.read(homeProvider).notify();
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: group.resource.network != null
                                      ? CachedNetworkImage(
                                          imageUrl: group.resource.network!,
                                          fit: BoxFit.fill,
                                          errorWidget: (context, url, error) => Image.asset(
                                            fit: BoxFit.fill,
                                            "assets/img/${group.text}.webp",
                                          ),
                                        )
                                      : Image.asset(
                                          fit: BoxFit.fill,
                                          "assets/img/${group.text}.webp",
                                        ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: AutoSizeText(
                                        group.text,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1,
                          mainAxisSpacing: 8,
                          mainAxisExtent: 119,
                        ),
                        controller: ref.read(homeProvider.select((value) => value.gridScrollController)),
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        itemCount: ref.watch(homeProvider.select((value) => value.pictograms.values.where((element) => !element.block && value.groups[currentGroup]!.relations.any((group) => group.id == element.id)).toList())).length,
                        itemBuilder: (ctx, index) {
                          Picto picto = ref.watch(homeProvider.select((value) => value.pictograms.values.where((element) => !element.block && value.groups[currentGroup]!.relations.any((group) => group.id == element.id)).toList()))[index];

                          return PictoWidget(
                            onTap: () {
                              addPictogram(picto);
                            },
                            colorNumber: picto.type,
                            image: picto.resource.network != null
                                ? CachedNetworkImage(
                                    imageUrl: picto.resource.network!,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => Image.asset(
                                      fit: BoxFit.fill,
                                      "assets/img/${picto.text}.webp",
                                    ),
                                  )
                                : Image.asset(
                                    fit: BoxFit.fill,
                                    "assets/img/${picto.text}.webp",
                                  ),
                            text: picto.text,
                            width: 116,
                            height: 144,
                          );
                        },
                      ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: HomeButton(
                        onPressed: () {
                          final provider = ref.watch(homeProvider);

                          provider.status = HomeScreenStatus.pictos;
                          provider.notify();
                        },
                        // size: const Size(40, 40),
                        child: Image.asset(
                          AppImages.kSearchOrange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: HomeButton(
                        // size: const Size(40, 40),
                        onPressed: groups.isEmpty ? null : () => ref.read(homeProvider.select((value) => value.scrollUp))(ref.read(homeProvider).gridScrollController, 96),
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: groups.isEmpty ? colorScheme.primary.withOpacity(.12) : colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: HomeButton(
                        // size: const Size(40, 40),
                        onPressed: groups.isEmpty ? null : () => ref.read(homeProvider.select((value) => value.scrollDown))(ref.read(homeProvider).gridScrollController, 96),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: groups.isEmpty ? colorScheme.primary.withOpacity(.12) : colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
