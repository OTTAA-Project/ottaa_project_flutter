import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/ui/shortcu_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/board_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/divider_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/shortcut_view.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/switch_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/tab_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class MainSettingScreen extends ConsumerWidget {
  const MainSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(userSettingsProvider);
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'user.settings.main_screen'.trl,
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
                'user.main_setting.interaction'.trl,
                style: textTheme.headline2!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.deleteText = value;
                  provider.notify();
                },
                title: 'user.main_setting.delete_talking'.trl,
                value: provider.deleteText,
              ),
              const DividerWidget(),
              Text(
                'customize.shortcut.appbar'.trl,
                style: textTheme.headline2!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.shortcut = value;
                  provider.notify();
                },
                title: 'user.main_setting.shortcut'.trl,
                value: provider.shortcut,
              ),
              const SizedBox(
                height: 32,
              ),
              const ShortcutView(),
              const DividerWidget(),
              Text(
                'user.main_setting.board_view'.trl,
                style: textTheme.headline2!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabWidget(
                    title: 'user.main_setting.tabs'.trl,
                    image: AppImages.kMainSettingsIcon1,
                    selected: provider.boardView,
                    onTap: () {
                      provider.boardView = true;
                      provider.notify();
                    },
                  ),
                  TabWidget(
                    title: 'user.main_setting.grid'.trl,
                    image: AppImages.kMainSettingsIcon2,
                    selected: !provider.boardView,
                    onTap: () {
                      provider.boardView = false;
                      provider.notify();
                    },
                  ),
                ],
              ),
              const DividerWidget(),
              Text(
                'user.main_setting.ottaa_labs'.trl,
                style: textTheme.headline2!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              SwitchWidget(
                onChanged: (value) {
                  provider.ottaaLabs = value;
                  provider.notify();
                },
                title: 'user.main_setting.labs_text'.trl,
                value: provider.ottaaLabs,
              ),
              Text(
                  'user.main_setting.labs_long'.trl,
                style: textTheme.headline2!.copyWith(fontSize: 14),
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
