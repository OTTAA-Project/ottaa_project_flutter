import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_ui_kit/theme.dart';

class BoardWidget extends ConsumerWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chatGPTProvider);
    final game = ref.watch(gameProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final groups = provider.gptBoards.map((e) => game.groups[e]).toList();
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 72,
      left: 24,
      child: SizedBox(
        height: size.height * 0.6,
        width: size.width * 0.8,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
            mainAxisExtent: 96,
          ),
          controller: ref.watch(chatGPTProvider.select((value) => value.boardScrollController)),
          padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32),
          itemCount: groups.length,
          itemBuilder: (ctx, index) {
            Group group = groups[index]!;

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
              onPressed: () async {
                await provider.fetchGptPictos(id: group.id);
                provider.boardOrPicto = false;
                provider.notify();
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
        ),
      ),
    );
  }
}
