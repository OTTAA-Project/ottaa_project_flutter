import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ShortcutsUI extends ConsumerStatefulWidget {
  const ShortcutsUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActionsBarState();
}

class _ActionsBarState extends ConsumerState<ShortcutsUI> {
  Future<void> showComingSoon() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("global.comingsoon".trl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pictos = ref.watch(homeProvider.select((value) => value.suggestedPicts));
    final provider = ref.read(gameProvider);

    final homeProv = ref.read(homeProvider);

    PatientUserModel? patient = ref.watch(patientNotifier);

    final size = MediaQuery.of(context).size;

    int shorcutsCount = patient?.patientSettings.layout.shortcuts.toMap().values.where((element) => element).length ?? 7;

    double shortCutSize = ((size.width - (32 * shorcutsCount)) / shorcutsCount);

    ShortcutsModel shortcuts = patient?.patientSettings.layout.shortcuts ?? ShortcutsModel.all();

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double iconSize = (shortCutSize * .5).clamp(!sizingInformation.isMobile ? 80 : 30, !sizingInformation.isMobile ? 90 : 38);
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 100,
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (patient == null || shortcuts.games)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null ? null : () => context.go(AppRoutes.patientGame),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardDiceIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            if (patient == null || shortcuts.history)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null ? null : showComingSoon,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardHistoryIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            if (patient == null || shortcuts.share)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null ? null : showComingSoon,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardShareIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            if (patient == null || shortcuts.camera)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null ? null : showComingSoon,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardCameraIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            if (patient == null || shortcuts.favs)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null ? null : showComingSoon,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardFavouriteIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            if (patient == null || shortcuts.yes)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null
                      ? null
                      : () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return WillPopScope(
                                  onWillPop: () async {
                                    return false;
                                  },
                                  child: const SizedBox(),
                                );
                              });
                          await homeProv.speakYes();
                          context.pop();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardYesIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
            if (patient == null || shortcuts.no)
              Flexible(
                fit: FlexFit.loose,
                child: HomeButton(
                  size: Size(shortCutSize, shortCutSize),
                  onPressed: pictos == null
                      ? null
                      : () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return WillPopScope(
                                onWillPop: () async {
                                  return false;
                                },
                                child: const SizedBox(),
                              );
                            },
                          );
                          await homeProv.speakNo();

                          context.pop();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.kBoardNoIconSelected,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
