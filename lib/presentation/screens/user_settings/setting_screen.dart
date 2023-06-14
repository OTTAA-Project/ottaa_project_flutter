import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_user_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class SettingScreenUser extends ConsumerStatefulWidget {
  const SettingScreenUser({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingScreenUser> createState() => _SettingScreenUserState();
}

class _SettingScreenUserState extends ConsumerState<SettingScreenUser> {
  @override
  void initState() {
    super.initState();
    final provider = ref.read(userSettingsProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await provider.init();
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider.select((value) => value.user));
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          title: Text(
            'global.settings'.trl,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ProfileUserWidget(
                title: 'user.settings.main_screen'.trl,
                onTap: () => context.push(user!.isCaregiver ? AppRoutes.caregiverAccountLayout : AppRoutes.patientSettingsLayout),
              ),
              ProfileUserWidget(
                title: 'user.settings.accessibility'.trl,
                onTap: () => context.push(user!.isCaregiver ? AppRoutes.caregiverAccountAccessibility : AppRoutes.patientSettingsAccessibility),
              ),
              ProfileUserWidget(
                title: 'user.settings.voice_and_subtitles'.trl,
                onTap: () => context.push(user!.isCaregiver ? AppRoutes.caregiverAccountTTS : AppRoutes.patientSettingsTTS),
              ),
              ProfileUserWidget(
                title: 'user.settings.language'.trl,
                onTap: () => context.push(user!.isCaregiver ? AppRoutes.caregiverAccountLanguage : AppRoutes.patientSettingsLanguage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
