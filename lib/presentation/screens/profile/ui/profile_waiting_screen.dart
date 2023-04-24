import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ProfileWaitingScreen extends ConsumerStatefulWidget {
  const ProfileWaitingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileWaitingScreen> createState() =>
      _ProfileWaitingScreenState();
}

class _ProfileWaitingScreenState extends ConsumerState<ProfileWaitingScreen> {
  @override
  void initState() {
    super.initState();

    final provider = ref.read(profileProvider);
    final user = ref.read(userNotifier);
    //todo: or we can use this callback
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.settingUpUserType();
      await Future.delayed(
        const Duration(seconds: 2),
        () => context.replace(AppRoutes.home),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //todo: can be converted to a dialouge and used with showDialouge

    return Scaffold(
      backgroundColor: kOTTAABackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "profile.wait".trl,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "profile.setting_exp".trl,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
