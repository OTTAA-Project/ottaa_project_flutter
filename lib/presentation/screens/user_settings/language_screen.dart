import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/chooser_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/ui/switch_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(userSettingsProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'user.settings.language'.trl,
          style: textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'user.settings.language'.trl,
              style: textTheme.headline2!.copyWith(
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'user.language.set'.trl,
              style: textTheme.headline3,
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 16,
              runSpacing: 16,
              children: [
                ChooserWidget(
                  selected: provider.language == 'es_AR' ? true : false,
                  onTap: () {
                    provider.language = 'es_AR';
                    provider.notify();
                  },
                  title: 'Español',
                ),
                ChooserWidget(
                  selected: provider.language == 'en_US' ? true : false,
                  onTap: () {
                    provider.language = 'en_US';
                    provider.notify();
                  },
                  title: 'English',
                ),
                ChooserWidget(
                  selected: provider.language == 'pt_BR' ? true : false,
                  onTap: () {
                    provider.language = 'pt_BR';
                    provider.notify();
                  },
                  title: 'Portugues',
                ),
                ChooserWidget(
                  selected: provider.language == 'it_IT' ? true : false,
                  onTap: () {
                    provider.language = 'es_AR';
                    provider.notify();
                  },
                  title: 'Italiano',
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
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
    );
  }
}
