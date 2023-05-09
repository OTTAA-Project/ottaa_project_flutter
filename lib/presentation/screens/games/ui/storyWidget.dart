import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/chat_gpt_game_provider.dart';
import 'package:picto_widget/picto_widget.dart';

class StoryWidget extends ConsumerWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chatGptGameProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width * 0.6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.gptPictos.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: PictoWidget(
                          onTap: () {},
                          image: provider.gptPictos[index].resource.network != null
                              ? CachedNetworkImage(
                                  imageUrl: provider.gptPictos[index].resource.network!,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => Image.asset(
                                    fit: BoxFit.fill,
                                    "assets/img/${provider.gptPictos[index].text}.webp",
                                  ),
                                )
                              : Image.asset(
                                  fit: BoxFit.fill,
                                  "assets/img/${provider.gptPictos[index].text}.webp",
                                ),
                          text: provider.gptPictos[index].text,
                          colorNumber: provider.gptPictos[index].type,
                          width: 96,
                          height: 119,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    provider.generatedStory,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  //todo: add the functions
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: colorScheme.primary,
                    size: 32,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  //todo: add the functions
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colorScheme.primary,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
