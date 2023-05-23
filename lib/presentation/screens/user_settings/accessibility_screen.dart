import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/core/enums/devices_accessibility.dart';
import 'package:ottaa_project_flutter/core/enums/sweep_modes.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/accessibility_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/chooser_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/divider_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/switch_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/tab_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class AccessibilityScreen extends ConsumerWidget {
  const AccessibilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    var sliderValue = ref.watch(userSettingsProvider).sliderValue;
    final provider = ref.read(userSettingsProvider);
    return WillPopScope(
      onWillPop: () async {
        provider.updateAccessibilitySettings();
        return true;
      },
      child: ResponsiveWidget(
        child: Scaffold(
          appBar: OTTAAAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                provider.updateAccessibilitySettings();
                context.pop();
              },
              splashRadius: 24,
            ),
            title: Text(
              'user.settings.accessibility'.trl,
              style: textTheme.displaySmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'user.accessibility.selection'.trl,
                    style:
                        textTheme.displayMedium!.copyWith(color: colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'user.accessibility.bar_text'.trl,
                    style: textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Slider(
                    label: sliderValue.toStringAsFixed(1),
                    divisions: 24,
                    value: sliderValue,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    thumbColor: colorScheme.primary,
                    min: 0.2,
                    max: 5.0,
                    onChanged: (value) {
                      provider.changeSpeed(value: value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('0.2'),
                        Text('5'),
                      ],
                    ),
                  ),
                  const DividerWidget(),
                  Text(
                    'user.accessibility.connected'.trl,
                    style:
                        textTheme.displayMedium!.copyWith(color: colorScheme.primary),
                  ),
                  SwitchWidget(
                    onChanged: (value) {
                      provider.changeDeviceOnOff(mode: value);
                    },
                    title: 'user.accessibility.device'.trl,
                    value: provider.accessibilitySetting.device ==
                            DevicesAccessibility.none
                        ? false
                        : true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AccessibilityWidget(
                            title: 'user.accessibility.press'.trl,
                            onTap: () {
                              provider.changeDevice(
                                  devicesAccessibility:
                                      DevicesAccessibility.press);
                            },
                            image: AppImages.kAccessibilityPhoto1,
                            selected: provider.accessibilitySetting.device ==
                                DevicesAccessibility.press,
                          ),
                          AccessibilityWidget(
                            title: 'user.accessibility.scroll'.trl,
                            onTap: () {
                              provider.changeDevice(
                                  devicesAccessibility:
                                      DevicesAccessibility.scroll);
                            },
                            image: AppImages.kAccessibilityPhoto2,
                            selected: provider.accessibilitySetting.device ==
                                DevicesAccessibility.scroll,
                          ),
                          AccessibilityWidget(
                            title: 'user.accessibility.sip'.trl,
                            onTap: () {
                              provider.changeDevice(
                                  devicesAccessibility:
                                      DevicesAccessibility.sipuff);
                            },
                            image: AppImages.kAccessibilityPhoto3,
                            selected: provider.accessibilitySetting.device ==
                                DevicesAccessibility.sipuff,
                          ),
                        ],
                      ),
                      provider.accessibilitySetting.device ==
                              DevicesAccessibility.none
                          ? Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width - 48,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const DividerWidget(),
                  Text(
                    'user.accessibility.selection_type'.trl,
                    style:
                        textTheme.displayMedium!.copyWith(color: colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TabWidget(
                        title: 'user.accessibility.selection'.trl,
                        image: AppImages.kAccessibilityIcon1,
                        selected: provider.accessibilitySetting.sweepMode ==
                                SweepModes.elements
                            ? true
                            : false,
                        onTap: () {
                          provider.changeSelection(modes: SweepModes.elements);
                        },
                      ),
                      TabWidget(
                        title: 'user.accessibility.swept'.trl,
                        image: AppImages.kAccessibilityIcon2,
                        selected: provider.accessibilitySetting.sweepMode ==
                                SweepModes.sweep
                            ? true
                            : false,
                        onTap: () {
                          provider.changeSelection(modes: SweepModes.sweep);
                        },
                      ),
                    ],
                  ),
                  const DividerWidget(),
                  Text(
                    'user.accessibility.speed'.trl,
                    style:
                        textTheme.displayMedium!.copyWith(color: colorScheme.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'user.accessibility.selection_speed'.trl,
                      style: textTheme.displaySmall,
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChooserWidget(
                        selected: provider.accessibilitySetting.sweepSpeed ==
                                VelocityTypes.slow
                            ? true
                            : false,
                        onTap: () {
                          provider.changeAccessibilitySpeed(
                              speed: VelocityTypes.slow);
                        },
                        title: 'global.slow'.trl,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ChooserWidget(
                          selected: provider.accessibilitySetting.sweepSpeed ==
                              VelocityTypes.mid,
                          onTap: () {
                            provider.changeAccessibilitySpeed(
                                speed: VelocityTypes.mid);
                          },
                          title: 'global.default'.trl,
                        ),
                      ),
                      ChooserWidget(
                        selected: provider.accessibilitySetting.sweepSpeed ==
                            VelocityTypes.fast,
                        onTap: () {
                          provider.changeAccessibilitySpeed(
                              speed: VelocityTypes.fast);
                        },
                        title: 'global.fast'.trl,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
