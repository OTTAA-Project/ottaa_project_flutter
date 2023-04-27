import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:picto_widget/picto_widget.dart';

class SentenceWidget extends ConsumerWidget {
  const SentenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: SizedBox(
        width: size.width,
        height: size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...provider.gptPictos
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: PictoWidget(
                        onTap: () {},
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
                        colorNumber: e.type,
                        width: 96,
                        height: 119,
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(
                width: 24,
              ),
              provider.gptPictos.length == 4
                  ? const SizedBox.shrink()
                  : PictoWidget(
                      image: Image.asset(AppImages.kAddIcon),
                      onTap: () async {
                        switch (provider.sentencePhase) {
                          ///using the same screen with different values
                          case 0:
                            provider.gptBoards.clear();
                            provider.gptBoards = provider.nounBoards;
                            provider.notify();
                            break;
                          case 1:
                            provider.gptBoards.clear();
                            provider.gptBoards.addAll(provider.modifierBoards);
                            provider.notify();
                            break;
                          case 2:
                            provider.gptBoards.clear();
                            provider.gptBoards.addAll(provider.actionBoards);
                            // provider.gptBoards = provider.actionBoards;
                            provider.notify();
                            break;
                          case 3:
                            provider.gptBoards.clear();
                            provider.gptBoards.addAll(provider.placeBoards);
                            // provider.gptBoards = provider.placeBoards;
                            provider.notify();
                            break;
                        }
                        context.push(AppRoutes.selectBoardPicto);
                      },
                      text: 'global.add'.trl,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
