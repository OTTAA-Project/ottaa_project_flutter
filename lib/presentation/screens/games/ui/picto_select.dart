import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/providers/chat_gpt_game_provider.dart';
import 'package:picto_widget/picto_widget.dart';

class PictoSelectWidget extends ConsumerWidget {
  const PictoSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final provider = ref.watch(chatGptGameProvider);
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      bottom: 72,
      left: 24,
      child: SizedBox(
        height: size.height * 0.6,
        width: size.width * 0.8,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
            mainAxisExtent: 150,
          ),
          controller: ref.watch(chatGptGameProvider.select((value) => value.pictoScrollController)),
          padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32),
          itemCount: provider.chatGptPictos.length,
          itemBuilder: (ctx, index) {
            return PictoWidget(
              onTap: () {
                provider.gptPictos.add(provider.chatGptPictos[index]);
                provider.isBoard = !provider.isBoard;
                provider.sentencePhase++;
                provider.notify();
                context.pop();
              },
              image: provider.chatGptPictos[index].resource.network != null
                  ? CachedNetworkImage(
                      imageUrl: provider.chatGptPictos[index].resource.network!,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Image.asset(
                        fit: BoxFit.fill,
                        "assets/img/${provider.chatGptPictos[index].text}.webp",
                      ),
                    )
                  : Image.asset(
                      fit: BoxFit.fill,
                      "assets/img/${provider.chatGptPictos[index].text}.webp",
                    ),
              text: provider.chatGptPictos[index].text,
              colorNumber: provider.chatGptPictos[index].type,
              width: 96,
              height: 119,
            );
          },
        ),
      ),
    );
  }
}
