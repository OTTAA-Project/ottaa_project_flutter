import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/providers/whats_the_picto_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_ui_kit/theme.dart';

class SelectGroupScreen extends ConsumerWidget {
  const SelectGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final user = ref.read(userNotifier);
    final colorScheme = Theme.of(context).colorScheme;
    final groups = ref.watch(homeProvider).groups.values.where((element) => !element.block).toList();
    final provider = ref.watch(gameProvider);
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'profile.hello'.trlf({'name': user!.settings.data.name}),
            subtitle: 'game.group'.trl,
          ),
          Positioned(
            bottom: size.height *0.2,
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
                controller: ref.watch(gameProvider.select((value) => value.gridScrollController)),
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
                    onPressed: () async {
                      provider.selectedGroupName = group.text;
                      await provider.fetchSelectedPictos();
                      provider.init();
                      final wtpProvider = ref.read(whatsThePictoProvider);
                      switch (provider.selectedGame) {
                        case 0:
                          await provider.createRandomForGameWTP();
                          wtpProvider.speakNameWhatsThePicto();
                          context.push(AppRoutes.gamePlayScreen);
                          break;
                        case 1:
                          await provider.createRandomForGameMP();
                          context.push(AppRoutes.gamePlayScreen);
                          break;
                        case 2:
                          context.push(AppRoutes.gamePlayScreen);
                          break;
                      }
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
          ),
          Positioned(
            right: 24,
            top: size.height * 0.3,
            child: GestureDetector(
              onTap: () {
                context.push(AppRoutes.searchScreen);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.search,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: size.height * 0.5,
            child: GestureDetector(
              onTap: () {
                provider.scrollUp();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: size.height * 0.7,
            child: GestureDetector(
              onTap: () {
                provider.scrollDown();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
