import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/actions_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class PictosBarUI extends ConsumerStatefulWidget {
  const PictosBarUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PictosBarState();
}

class _PictosBarState extends ConsumerState<PictosBarUI> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final size = MediaQuery.of(context).size;
      int pictoSize = 116;

      //We are using size.height because at this time the screen is not rotated
      int pictoCount = kIsTablet ? 6 : 4;

      final setSuggested = ref.read(homeProvider.select((value) => value.setSuggedtedQuantity));

      setSuggested(pictoCount);

      await ref.read(homeProvider.select((value) => value.init))();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    final pictos = ref.watch(homeProvider).getPictograms();

    final addPictogram = ref.read(homeProvider.select((value) => value.addPictogram));

    int pictoSize = 116;

    int pictoCount = ((size.width - 200) / pictoSize).floor();

    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30),
              pictos.isEmpty
                  ? const Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : buildWidgets(pictos, addPictogram: addPictogram),
              const SizedBox(width: 30),
              SizedBox(
                width: 64,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeButton(
                      onPressed: pictos.isEmpty
                          ? null
                          : () {
                              final provider = ref.watch(homeProvider);

                              provider.status = HomeScreenStatus.search;
                              provider.notify();
                            },
                      size: const Size(64, 64),
                      child: Image.asset(
                        AppImages.kSearchOrange,
                      ),
                    ),
                    HomeButton(
                      onPressed: pictos.isEmpty
                          ? null
                          : () {
                              ref.read(homeProvider).refreshPictograms();
                            },
                      size: const Size(64, 64),
                      child: Image.asset(
                        AppImages.kRefreshOrange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          height: 88,
          child: const ActionsBarUI(),
        )
      ],
    );
  }

  Flexible buildWidgets(
    List<Picto> pictos, {
    required void Function(Picto) addPictogram,
  }) {
    return Flexible(
      fit: FlexFit.loose,
      child: GridView.builder(
        itemCount: pictos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: kIsTablet ? 6 : 4,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final e = pictos[index];

          return PictoWidget(
            onTap: () {
              addPictogram(e);
            },
            colorNumber: e.type,
            image: e.resource.network != null
                ? CachedNetworkImage(
                    imageUrl: e.resource.network!,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Image.asset(
                      fit: BoxFit.fill,
                      "assets/img/${e.text}.webp",
                    ),
                  )
                : Image.asset(
                    fit: BoxFit.fill,
                    "assets/img/${e.text}.webp",
                  ),
            text: e.text,
            width: 116,
            height: 144,
          );
        },
      ),
    );
  }
}
