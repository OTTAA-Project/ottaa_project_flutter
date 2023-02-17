import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/resource_image.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/actions_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class GroupsHomeUi extends ConsumerStatefulWidget {
  const GroupsHomeUi({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsHomeUi();
}

class _GroupsHomeUi extends ConsumerState<GroupsHomeUi> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    final groups = ref.watch(homeProvider).groups.values.where((element) => !element.block).toList();

    final currentGroup = ref.watch(homeProvider).groups[ref.watch(homeProvider).currentGroup];

    final pictos = ref.watch(homeProvider).pictograms.values.where((element) => !element.block && currentGroup!.relations.any((group) => group.id == element.id)).toList();

    final addPictogram = ref.read(homeProvider.select((value) => value.addPictogram));

    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const SizedBox(width: 24),
              SizedBox(
                width: 40,
                height: 40,
                child: HomeButton(
                  onPressed: groups.isEmpty
                      ? null
                      : () {
                          final controller = ref.read(homeProvider.select((value) => value.groupGridScrollController));

                          double offset = (controller.offset - 168);

                          if (offset < 0) {
                            offset = controller.position.maxScrollExtent;
                          }

                          controller.animateTo(
                            offset,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ListView.separated(
                    controller: ref.read(homeProvider.select((value) => value.groupGridScrollController)),
                    scrollDirection: Axis.horizontal,
                    itemCount: groups.length,
                    separatorBuilder: (ctx, index) => const SizedBox(
                      width: 16,
                    ),
                    cacheExtent: 150,
                    itemBuilder: (ctx, index) {
                      Group group = groups.elementAt(index);

                      bool isCurrent = ref.watch(homeProvider).currentGroup == group.id;

                      return GestureDetector(
                        onTap: () {
                          ref.read(homeProvider.select((value) => value.setCurrentGroup)).call(group.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCurrent ? kBlackColor : Colors.white,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          height: 48,
                          width: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: ResourceImage(
                                  image: group.resource,
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutoSizeText(
                                  group.text,
                                  softWrap: true,
                                  maxLines: 2,
                                  minFontSize: 8,
                                  style: TextStyle(
                                    color: !isCurrent ? kBlackColor : Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 40,
                height: 40,
                child: HomeButton(
                  onPressed: groups.isEmpty
                      ? null
                      : () {
                          final controller = ref.read(homeProvider.select((value) => value.groupGridScrollController));

                          double offset = controller.offset + 168;
                          if (offset > controller.position.maxScrollExtent) {
                            offset = 0;
                          }

                          controller.animateTo(
                            offset,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    mainAxisExtent: 144,
                  ),
                  controller: ref.read(homeProvider.select((value) => value.pictoGridScrollController)),
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  itemCount: pictos.length,
                  itemBuilder: (ctx, index) {
                    Picto picto = pictos[index];

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
                        size: const Size(40, 40),
                        child: Image.asset(
                          AppImages.kSearchOrange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: HomeButton(
                        size: const Size(40, 40),
                        onPressed: groups.isEmpty ? null : ref.watch(homeProvider.select((value) => value.goGroupsUp)),
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
                        size: const Size(40, 40),
                        onPressed: groups.isEmpty ? null : ref.watch(homeProvider.select((value) => value.goGroupsDown)),
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
