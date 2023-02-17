import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_button.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ActionsBarUI extends ConsumerStatefulWidget {
  const ActionsBarUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActionsBarState();
}

class _ActionsBarState extends ConsumerState<ActionsBarUI> {
  @override
  Widget build(BuildContext context) {
    final pictos = ref.watch(homeProvider.select((value) => value.suggestedPicts.isEmpty));

    final colorScheme = Theme.of(context).colorScheme;

    PatientUserModel? patient = ref.watch(patientNotifier);

    UserModel? user = ref.watch(userNotifier);

    print(patient?.patientSettings.shortcuts);

    return Flex(
      direction: Axis.horizontal,
      children: [
        const SizedBox(width: 30),
        Flexible(
          fit: FlexFit.loose,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.games)
                Expanded(
                  child: HomeButton(
                    size: const Size(64, 64),
                    onPressed: pictos ? null : () {},
                    child: Image.asset(
                      AppImages.kBoardDiceIconSelected,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.history)
                Expanded(
                  child: HomeButton(
                    size: const Size(64, 64),
                    onPressed: pictos ? null : () {},
                    child: Image.asset(
                      AppImages.kBoardHistoryIconSelected,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.share)
                Expanded(
                  child: HomeButton(
                    size: const Size(64, 64),
                    onPressed: pictos ? null : () {},
                    child: Image.asset(
                      AppImages.kBoardShareIconSelected,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.camera)
                Expanded(
                  child: HomeButton(
                    size: const Size(64, 64),
                    onPressed: pictos ? null : () {},
                    child: Image.asset(
                      AppImages.kBoardCameraIconSelected,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.yes)
                Expanded(
                  child: HomeButton(
                    size: const Size(64, 64),
                    onPressed: pictos ? null : () {},
                    child: Image.asset(
                      AppImages.kBoardYesIcon,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.no)
                Expanded(
                  child: HomeButton(
                    size: const Size(64, 64),
                    onPressed: pictos ? null : () {},
                    child: Image.asset(
                      AppImages.kBoardNoIcon,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.yes)
                Expanded(
                  child: BaseButton(
                    onPressed: pictos ? null : () {},
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size.fromHeight(64)),
                      backgroundColor: MaterialStateProperty.all(pictos ? Colors.grey.withOpacity(.12) : Colors.white),
                      overlayColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                      ),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Image.asset(
                      AppImages.kBoardYesIcon,
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (patient == null || patient.patientSettings.shortcuts.no)
                Expanded(
                  child: BaseButton(
                    onPressed: pictos ? null : () {},
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size.fromHeight(64)),
                      backgroundColor: MaterialStateProperty.all(pictos ? Colors.grey.withOpacity(.12) : Colors.white),
                      overlayColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                      ),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Image.asset(
                      AppImages.kBoardNoIcon,
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}
