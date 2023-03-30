import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';

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
    final pictos = ref.watch(homeProvider.select((value) => value.suggestedPicts.isEmpty));

    final tts = ref.watch(ttsProvider);

    PatientUserModel? patient = ref.watch(patientNotifier);

    final size = MediaQuery.of(context).size;

    int shorcutsCount = patient?.patientSettings.layout.shortcuts.toMap().values.where((element) => element).length ?? 7;

    double shortCutSize = (size.width - (32 * shorcutsCount)) / shorcutsCount;

    ShortcutsModel shortcuts = patient?.patientSettings.layout.shortcuts ?? ShortcutsModel.all();

    return SizedBox(
      height: 64,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (patient == null || shortcuts.games)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos ? null : showComingSoon,
                child: Image.asset(
                  AppImages.kBoardDiceIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          if (patient == null || shortcuts.history)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos ? null : showComingSoon,
                child: Image.asset(
                  AppImages.kBoardHistoryIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          if (patient == null || shortcuts.share)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos ? null : showComingSoon,
                child: Image.asset(
                  AppImages.kBoardShareIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          if (patient == null || shortcuts.camera)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos ? null : showComingSoon,
                child: Image.asset(
                  AppImages.kBoardCameraIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          if (patient == null || shortcuts.favs)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos ? null : showComingSoon,
                child: Image.asset(
                  AppImages.kBoardFavouriteIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          if (patient == null || shortcuts.yes)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos
                    ? null
                    : () async {
                        await tts.speak("global.yes".trl);
                      },
                child: Image.asset(
                  AppImages.kBoardYesIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          if (patient == null || shortcuts.no)
            Flexible(
              fit: FlexFit.loose,
              child: HomeButton(
                size: Size(shortCutSize, 64),
                onPressed: pictos
                    ? null
                    : () async {
                        await tts.speak("global.no".trl);
                      },
                child: Image.asset(
                  AppImages.kBoardNoIconSelected,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
