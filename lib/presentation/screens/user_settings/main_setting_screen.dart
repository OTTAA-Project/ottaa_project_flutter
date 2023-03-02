import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/core/enums/display_types.dart';
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
    return WillPopScope(
      onWillPop: () async {
        provider.updateMainSettings();
        return true;
      },
      child: Scaffold(
        appBar: OTTAAAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              provider.updateMainSettings();
              context.pop();
            },
            splashRadius: 24,
          ),
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
                    provider.changeDeleteText(value: value);
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
                    provider.changeEnableShortcuts(value: value);
                  },
                  title: 'user.main_setting.shortcut'.trl,
                  value: provider.layoutSetting.shortcuts.enable,
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
                      selected: provider.layoutSetting.display == DisplayTypes.tab,
                      onTap: () {
                        provider.changeTablet(value: DisplayTypes.tab);
                      },
                    ),
                    TabWidget(
                      title: 'user.main_setting.grid'.trl,
                      image: AppImages.kMainSettingsIcon2,
                      selected: provider.layoutSetting.display == DisplayTypes.grid,
                      onTap: () {
                        provider.changeTablet(value: DisplayTypes.grid);
                      },
                    ),
                  ],
                ),
                const DividerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
