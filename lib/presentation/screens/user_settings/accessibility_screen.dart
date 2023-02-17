import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
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
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'user.settings.accessibility'.trl,
          style: textTheme.headline3,
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
                    textTheme.headline2!.copyWith(color: colorScheme.primary),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'user.accessibility.bar_text'.trl,
                style: textTheme.headline3,
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
                  provider.sliderValue = value;
                  print(value);
                  provider.notify();
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
                    textTheme.headline2!.copyWith(color: colorScheme.primary),
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.accessibility = value;
                  provider.notify();
                },
                title: 'user.accessibility.device'.trl,
                value: provider.accessibility,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AccessibilityWidget(
                    title: 'user.accessibility.press'.trl,
                    onTap: () {
                      provider.selectedAccessibility = 0;
                      provider.notify();
                    },
                    image: AppImages.kAccessibilityPhoto1,
                    selected:
                        provider.selectedAccessibility == 0 ? true : false,
                  ),
                  AccessibilityWidget(
                    title: 'user.accessibility.scroll'.trl,
                    onTap: () {
                      provider.selectedAccessibility = 1;
                      provider.notify();
                    },
                    image: AppImages.kAccessibilityPhoto2,
                    selected:
                        provider.selectedAccessibility == 1 ? true : false,
                  ),
                  AccessibilityWidget(
                    title: 'user.accessibility.sip'.trl,
                    onTap: () {
                      provider.selectedAccessibility = 2;
                      provider.notify();
                    },
                    image: AppImages.kAccessibilityPhoto3,
                    selected:
                        provider.selectedAccessibility == 2 ? true : false,
                  ),
                ],
              ),
              const DividerWidget(),
              Text(
                'user.accessibility.selection_type'.trl,
                style:
                    textTheme.headline2!.copyWith(color: colorScheme.primary),
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
                    selected: provider.accessibilityType,
                    onTap: () {
                      provider.accessibilityType = true;
                      provider.notify();
                    },
                  ),
                  TabWidget(
                    title: 'user.accessibility.swept'.trl,
                    image: AppImages.kAccessibilityIcon2,
                    selected: !provider.accessibilityType,
                    onTap: () {
                      provider.accessibilityType = false;
                      provider.notify();
                    },
                  ),
                ],
              ),
              const DividerWidget(),
              Text(
                'user.accessibility.speed'.trl,
                style:
                    textTheme.headline2!.copyWith(color: colorScheme.primary),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'user.accessibility.selection_speed'.trl,
                  style: textTheme.headline3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChooserWidget(
                    selected: provider.accessibilitySpeed == 0 ? true : false,
                    onTap: () {
                      provider.accessibilitySpeed = 0;
                      provider.notify();
                    },
                    title: 'global.slow'.trl,
                  ),
                  ChooserWidget(
                    selected: provider.accessibilitySpeed == 1 ? true : false,
                    onTap: () {
                      provider.accessibilitySpeed = 1;
                      provider.notify();
                    },
                    title: 'global.default'.trl,
                  ),
                  ChooserWidget(
                    selected: provider.accessibilitySpeed == 2 ? true : false,
                    onTap: () {
                      provider.accessibilitySpeed = 2;
                      provider.notify();
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
    );
  }
}
